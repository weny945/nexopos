<?php

namespace App\Services;

use Illuminate\Support\Facades\Crypt;
use Illuminate\Encryption\EncryptException;
use Illuminate\Contracts\Encryption\DecryptException;
use Exception;

class PaymentCodeSecurityService
{
    /**
     * Encrypt sensitive data before saving to database
     *
     * @param string|null $value
     * @return string|null
     */
    public static function encrypt($value)
    {
        if (empty($value)) {
            return $value;
        }

        try {
            return encrypt($value);
        } catch (EncryptException $e) {
            // If encryption fails, return original value
            return $value;
        }
    }

    /**
     * Decrypt sensitive data from database
     *
     * @param string|null $value
     * @return string|null
     */
    public static function decrypt($value)
    {
        if (empty($value)) {
            return $value;
        }

        try {
            return decrypt($value);
        } catch (DecryptException $e) {
            // If decryption fails (might be plain text), return original
            return $value;
        } catch (EncryptException $e) {
            // If decryption fails (might be plain text), return original
            return $value;
        } catch (Exception $e) {
            // If any other error occurs, return original
            return $value;
        }
    }

    /**
     * Mask sensitive data for display
     *
     * @param string|null $value
     * @param int $showChars Number of characters to show at the end
     * @return string|null
     */
    public static function mask($value, $showChars = 4)
    {
        if (empty($value)) {
            return $value;
        }

        $length = strlen($value);

        if ($length <= $showChars) {
            return $value;
        }

        // Show first and last few characters, mask the middle
        return substr($value, 0, 2) . str_repeat('*', $length - $showChars) . substr($value, -$showChars);
    }

    /**
     * Check if value is encrypted
     *
     * @param string $value
     * @return bool
     */
    public static function isEncrypted($value)
    {
        if (empty($value)) {
            return false;
        }

        // Laravel encrypted strings are base64 encoded and typically start with specific patterns
        // This is a simple heuristic check
        try {
            decrypt($value);
            return true;
        } catch (EncryptException $e) {
            return false;
        }
    }
}
