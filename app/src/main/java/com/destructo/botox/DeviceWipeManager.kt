package com.destructo.botox

import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.os.Build

class DeviceWipeManager(private val ctx: Context) {
    private val dpm = ctx.getSystemService(DevicePolicyManager::class.java)
    private val deviceAdmin by lazy { ComponentName(ctx, DeviceAdminReceiver::class.java) }

    // Method to perform wipe data
    fun performWipe() {
        // WIPE_SILENTLY is only guaranteed for device/profile owners. On newer
        // Android versions a plain active admin can be rejected, so fall back
        // to a normal wipe instead of leaving the device untouched.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            try {
                CleanSlateLog.log("WIPE_SILENTLY")
                dpm?.wipeData(DevicePolicyManager.WIPE_SILENTLY)
                CleanSlateLog.log("SUCCESS")
                return
            } catch (e: SecurityException) {
                CleanSlateLog.log("WIPE_SILENTLY reddedildi, normal wipe denenecek: $e")
            } catch (e: Exception) {
                CleanSlateLog.log("WIPE_SILENTLY hatasi, normal wipe denenecek: $e")
            }
        }

        try {
            dpm?.wipeData(0)
            CleanSlateLog.log("SUCCESS")
        } catch (e: Exception) {
            CleanSlateLog.log(e.toString())
        }
    }
}