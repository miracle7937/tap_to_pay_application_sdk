package com.example.tap_to_pay_plugin;

import android.os.Build;
import android.os.Bundle;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;

import androidx.appcompat.app.AppCompatActivity;

import com.e.tapready.Tprd_MessageIntents;
import com.e.tapready.Tprd_TTP;

import org.jetbrains.annotations.Nullable;

public class TransactionActivity extends AppCompatActivity {

    private static final String TAG = "TransactionActivity";

    // Step 1: Create a BroadcastReceiver
    private BroadcastReceiver messageReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (Tprd_MessageIntents.ACTION_RECEIVE_MESSAGE.equals(intent.getAction())) {
                String receivedString = intent.getStringExtra("YOUR_STRING_EXTRA");
                Log.i(TAG, "RESPONSE: " + receivedString);

                if ("TPRD_RET_OK".equalsIgnoreCase(receivedString)) {
                    // Successful transaction
                    Tprd_TTP tprd_test = new Tprd_TTP(getApplicationContext());
                    String transactionPinblock = tprd_test.getPinblock("946D3838C15D01AEAD76A840C18002EA"); // Replace with actual PIN key
                    String emvTags = tprd_test.getEmvTags();
                    String iccData = tprd_test.getIccData();

                    Log.i(TAG, "PINBLOCK: " + transactionPinblock);
                    Log.i(TAG, "EMV TAGS: " + emvTags);
                    Log.i(TAG, "ICC DATA: " + iccData);
                } else {
                    // Transaction failed
                    Log.e(TAG, "Transaction failed with response: " + receivedString);
                }
            }
        }
    };

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_transaction);

        // Step 2: Register the BroadcastReceiver
        IntentFilter intentFilter = new IntentFilter(Tprd_MessageIntents.ACTION_RECEIVE_MESSAGE);
        registerReceiver(messageReceiver, intentFilter, Context.RECEIVER_NOT_EXPORTED);

        // Step 3: Start the transaction
        initiateTransaction();
    }

    private void initiateTransaction() {
        Tprd_TTP tprd_ttp = new Tprd_TTP(this);
        String transactionKey = "hjvkvgtjyftfjghchrdru556tjfdj"; // Replace with your actual key
        int amountInKobo = 200; // N2.00 in kobo
        Log.i(TAG, "Starting transaction with amount: " + amountInKobo);
        tprd_ttp.startTransaction(amountInKobo, transactionKey);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // Unregister the BroadcastReceiver to avoid memory leaks
        unregisterReceiver(messageReceiver);
    }
}


