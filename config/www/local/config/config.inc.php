<?php
// Custom configuration for Piwigo

// Allow Chinese characters in file/directory names during synchronization
// This regex allows Unicode letters, numbers, spaces, and common punctuation
$conf['sync_chars_regex'] = '/^[-_.\p{L}\p{N}\p{Z}()\[\]]+$/u';

// Ensure galleries directory is accessible
// The galleries path should be relative to Piwigo root
// For Railway deployment, galleries are in /var/www/html/galleries/
?>

