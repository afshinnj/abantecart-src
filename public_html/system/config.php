<?php
/**
	AbanteCart, Ideal OpenSource Ecommerce Solution
	http://www.AbanteCart.com
	Copyright © 2011-'.date('Y').' Belavier Commerce LLC

	Released under the Open Software License (OSL 3.0)
*/
// Admin Section Configuration. You can change this value to any name. Will use ?s=name to access the admin
define('ADMIN_PATH', 'admin');

// Database Configuration
define('DB_DRIVER', 'amysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_DATABASE', 'a');
define('DB_PREFIX', 'abc_');
// Unique AbanteCart store ID
define('UNIQUE_ID', '81195677820d69f8a9c6f989849ab479');
// Salt key for oneway encryption of passwords. NOTE: Change of SALT key will cause a loss of all existing users' and customers' passwords!
define('SALT', 'GfcC');
// Encryption key for protecting sensitive information. NOTE: Change of this key will cause a loss of all existing encrypted information!
define('ENCRYPTION_KEY', 'T9hL97');
