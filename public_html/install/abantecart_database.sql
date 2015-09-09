SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- DDL for table `address`
--
-- NOTE: If update table keep in mind ac_addresses_enc
--
DROP TABLE IF EXISTS `ac_addresses`;
CREATE TABLE `ac_addresses` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `company` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `firstname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `lastname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `address_1` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `address_2` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `postcode` varchar(10) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `city` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `country_id` int(11) NOT NULL DEFAULT '0',
  `zone_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`address_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
CREATE INDEX `ac_addresses_idx` ON `ac_addresses` ( `customer_id`, `country_id`, `zone_id`  );

--
-- DDL for table `categories`
--
DROP TABLE IF EXISTS `ac_categories`;
CREATE TABLE `ac_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '1',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
CREATE INDEX `ac_categories_idx` ON `ac_categories` ( `category_id`, `parent_id`, `status`  );

--
-- DDL for table `category_descriptions`
--
DROP TABLE IF EXISTS `ac_category_descriptions`;
CREATE TABLE `ac_category_descriptions` (
  `category_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'translatable',
  `meta_keywords` varchar(255) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `meta_description` varchar(255) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `description` text COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`category_id`,`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `categories_to_stores`
--
DROP TABLE IF EXISTS `ac_categories_to_stores`;
CREATE TABLE `ac_categories_to_stores` (
  `category_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- DDL for table `countries`
--
DROP TABLE IF EXISTS `ac_countries`;
CREATE TABLE `ac_countries` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `iso_code_2` varchar(2) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `iso_code_3` varchar(3) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `address_format` text COLLATE utf8_general_ci NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  `sort_order` int(3) NOT NULL DEFAULT '0',  
  PRIMARY KEY (`country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
CREATE INDEX `ac_countries_idx` ON `ac_countries` ( `iso_code_2`, `iso_code_3`, `status`  );

--
-- Dumping data for table `countries`
--
INSERT INTO `ac_countries` (`country_id`, `iso_code_2`, `iso_code_3`, `address_format`, `status`, `sort_order`) 
VALUES
(101,'IR','IRN','',1,0);
--
-- DDL for table `ac_country_descriptions`
--
DROP TABLE IF EXISTS `ac_country_descriptions`;
CREATE TABLE `ac_country_descriptions` (
  `country_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`country_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_country_descriptions` (`country_id`, `language_id`, `name`) 
VALUES 
(101,1,'جمهوری اسلامی ایران');


--
-- DDL for table `coupons`
--
DROP TABLE IF EXISTS `ac_coupons`;
CREATE TABLE `ac_coupons` (
  `coupon_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) COLLATE utf8_general_ci NOT NULL,
  `type` char(1) COLLATE utf8_general_ci NOT NULL,
  `discount` decimal(15,4) NOT NULL,
  `logged` int(1) NOT NULL,
  `shipping` int(1) NOT NULL,
  `total` decimal(15,4) NOT NULL,
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  `uses_total` int(11) NOT NULL,
  `uses_customer` varchar(11) COLLATE utf8_general_ci NOT NULL,
  `status` int(1) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`coupon_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;


--
-- DDL for table `coupon_descriptions`
--
DROP TABLE IF EXISTS `ac_coupon_descriptions`;
CREATE TABLE `ac_coupon_descriptions` (
  `coupon_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `description` text COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`coupon_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `coupon_products`
--
DROP TABLE IF EXISTS `ac_coupons_products`;
CREATE TABLE `ac_coupons_products` (
  `coupon_product_id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`coupon_product_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_coupons_products_idx` ON `ac_coupons_products` ( `coupon_id`, `product_id`  );


--
-- DDL for table `currencies`
--
DROP TABLE IF EXISTS `ac_currencies`;
CREATE TABLE `ac_currencies` (
  `currency_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `code` varchar(3) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `symbol_left` varchar(12) COLLATE utf8_general_ci NOT NULL,	
  `symbol_right` varchar(12) COLLATE utf8_general_ci NOT NULL,
  `decimal_place` char(1) COLLATE utf8_general_ci NOT NULL,
  `value` decimal(15,8) NOT NULL,
  `status` int(1) NOT NULL,
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`currency_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `currency`
--

INSERT INTO `ac_currencies` (`currency_id`, `title`, `code`, `symbol_left`, `symbol_right`, `decimal_place`, `value`, `status`, `date_modified`) VALUES
(1, 'IR Rial', 'IRR', '', 'ریال', '0', '1.00000000', 1, '1394-05-27 11:29:14'),
(2, 'IR Toman', 'IRT', '', 'تومان', '0', '0.10000000', 1, '1394-05-27 11:29:14');

--
-- DDL for table `customers`
--
-- NOTE: If update table keep in mind ac_customers_enc
--

DROP TABLE IF EXISTS `ac_customers`;
CREATE TABLE `ac_customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `firstname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `lastname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `loginname` varchar(96) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` varchar(96) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `telephone` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fax` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(40) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `cart` text COLLATE utf8_general_ci,
  `wishlist` text COLLATE utf8_general_ci,
  `newsletter` int(1) NOT NULL DEFAULT '0',
  `address_id` int(11) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL,
  `approved` int(1) NOT NULL DEFAULT '0',
  `customer_group_id` int(11) NOT NULL,
  `ip` varchar(15) COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customers_loginname` (`loginname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_customers_idx` ON `ac_customers` ( `store_id`, `address_id`, `customer_group_id` );

--
-- DDL for table `customer_groups`
--
DROP TABLE IF EXISTS `ac_customer_groups`;
CREATE TABLE `ac_customer_groups` (
  `customer_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`customer_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `ac_customer_groups` ( `name`) VALUES
('پیش فرض'),
('عمده فروشان'),
('مشترک خبرنامه');


--
-- DDL for table table `ac_customer_transactions`
--
DROP TABLE IF EXISTS `ac_customer_transactions`;
CREATE TABLE `ac_customer_transactions` (
  `customer_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL DEFAULT '0',
  `order_id` int(11) NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL  COMMENT 'user_id for admin, customer_id for storefront section',
  `section` smallint(1) NOT NULL DEFAULT '0' COMMENT '1 - admin, 0 - customer',
  `credit` float DEFAULT '0',
  `debit` float DEFAULT '0',
  `transaction_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'text type of transaction',
  `comment` text COMMENT 'comment for internal use',
  `description` text COMMENT 'text for customer',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`customer_transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
CREATE INDEX `ac_customer_transactions_idx` ON `ac_customer_transactions` ( `customer_id`, `order_id` );

--
-- DDL for table `ac_online_customers`
--

DROP TABLE IF EXISTS `ac_online_customers`;
CREATE TABLE `ac_online_customers` (
  `customer_id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `url` text NOT NULL,
  `referer` text NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- DDL for table `download`
--
DROP TABLE IF EXISTS `ac_downloads`;
CREATE TABLE `ac_downloads` (
  `download_id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(128) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mask` varchar(128) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `max_downloads` int(11) DEFAULT NULL, -- remaining, NULL -> No limit 
  `expire_days` int(11) DEFAULT NULL,  -- default to NULL -> No expiration
  `sort_order` int(11) NOT NULL,  
  `activate` varchar(64) NOT NULL,
  `activate_order_status_id` int(11) NOT NULL DEFAULT '0',
  `shared` int(1) NOT NULL DEFAULT '0', -- if used by other products set to 1
  `status` int(1) NOT NULL DEFAULT '0', -- in migration set to 1
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY (`download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
CREATE INDEX `ac_downloads_idx` ON `ac_downloads` ( `activate_order_status_id`, `shared` );
--
-- DDL for table `download_descriptions`
--
DROP TABLE IF EXISTS `ac_download_descriptions`;
CREATE TABLE `ac_download_descriptions` (
  `download_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'translatable',
  PRIMARY KEY (`download_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- All data is taken from global attribute
DROP TABLE IF EXISTS `ac_download_attribute_values`;
CREATE TABLE `ac_download_attribute_values` (
  `download_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_id` int(11) NOT NULL,
  `download_id` int(11) NOT NULL,
  `attribute_value_ids` text COLLATE utf8_general_ci  DEFAULT NULL,  -- serialized aray with value IDs
  PRIMARY KEY (`download_attribute_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_download_attribute_values_idx` ON `ac_download_attribute_values` ( `attribute_id`, `download_id` );

--
-- DDL for table `extensions`
--
DROP TABLE IF EXISTS `ac_extensions`;
CREATE TABLE `ac_extensions` (
  `extension_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `key` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `category` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `status` smallint(1) NOT NULL,
  `priority` smallint(1) NOT NULL DEFAULT 0,
  `version` varchar(32),
  `license_key` varchar(32),
  `date_installed` timestamp NOT NULL default '0000-00-00 00:00:00',
  `date_added` timestamp NOT NULL default '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`extension_id`),
  UNIQUE KEY `extension_key` (`key`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `extension`
--

INSERT INTO `ac_extensions` (`type`, `key`, `category`, `status`, `priority`, `version`, `license_key`, `date_installed`, `date_modified`, `date_added`) VALUES

('total', 'coupon', '', 1, 1, '', null, now(), now(), now() ),
('total', 'shipping', 'shipping', 1, 1, '', null, now(), now(), now() ),
('total', 'low_order_fee', '', 0, 1, '', null, now(), now(), now() ),
('total', 'handling', '', 0, 1, '', null, now(), now(), now() ),
('total', 'sub_total', '', 1, 1, '', null, now(), now(), now() ),
('total', 'tax', '', 1, 1, '', null, now(), now(), now() ),
('total', 'total', '', 1, 1, '', null, now(), now(), now() ),
('total', 'balance', '', 1, 1, '', null, now(), now(), now() ),

('block', 'cart', '', 1, 1, '', null, now(), now(), now() ),
('block', 'category', '', 1, 1, '', null, now(), now(), now() ),
('block', 'content', '', 1, 1, '', null, now(), now(), now() ),
('block', 'manufacturer', '', 1, 1, '', null, now(), now(), now() ),
('block', 'bestseller', '', 1, 1, '', null, now(), now(), now() ),
('block', 'latest', '', 1, 1, '', null, now(), now(), now() ),
('block', 'featured', '', 1, 1, '', null, now(), now(), now() ),

('extensions', 'banner_manager', 'extensions', 1, 1, '1.0.1', null, now(), now(), now() ),
('extensions', 'forms_manager', 'extensions', 1, 1, '1.0.2', null, now(), now(), now() ),
('payment', 'default_pp_standart', 'payment', 0, 1, '1.0.2', null, now(), now() + INTERVAL 1 HOUR , now() ),
('payment', 'default_pp_pro', 'payment', 0, 1, '1.0.2', null, now(), now() + INTERVAL 1 HOUR , now() )
;

--
-- DDL for tables of banner manager
--
DROP TABLE IF EXISTS `ac_banners`;
CREATE TABLE `ac_banners` (
	`banner_id` int(11) NOT NULL AUTO_INCREMENT,
	`status` int(1) NOT NULL DEFAULT '0',
	`banner_type` int(11) NOT NULL DEFAULT '1',
	`banner_group_name` varchar(255) NOT NULL DEFAULT '',
	`start_date` timestamp NULL DEFAULT NULL,
	`end_date` timestamp NULL DEFAULT NULL,
	`blank` tinyint(1) NOT NULL DEFAULT '0',
	`target_url` text COLLATE utf8_general_ci DEFAULT '',
	`sort_order` int(11) NOT NULL,
	`date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
	`date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`banner_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `ac_banner_descriptions`;
CREATE TABLE `ac_banner_descriptions` (
  `banner_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'translatable',
  `description` text COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `meta` text(1500) DEFAULT '' COMMENT 'translatable',
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`banner_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `ac_banner_stat`;
CREATE TABLE `ac_banner_stat` (
	`rowid` INT NOT NULL AUTO_INCREMENT,
  `banner_id` int(11) NOT NULL,
  `type` int(11) NOT NULL, -- 1 = view, 2 = click
  `time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `store_id` int(11) NOT NULL,
  `user_info` text(1500) DEFAULT '',
PRIMARY KEY (`rowid`),
INDEX `ac_banner_stat_idx` (`banner_id`, `type`, `time`, `store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- DDL for table `locations`
--
DROP TABLE IF EXISTS `ac_locations`;
CREATE TABLE `ac_locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`location_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `ac_locations`
--

INSERT INTO `ac_locations` (`location_id`, `name`, `description`, `date_added`) VALUES
(1, 'IR', 'IRAN', now());

--
-- DDL for table `languages`
--
DROP TABLE IF EXISTS `ac_languages`;
CREATE TABLE `ac_languages` (
  `language_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `code` varchar(5) COLLATE utf8_general_ci NOT NULL,
  `locale` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `directory` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `filename` varchar(64) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL,
  PRIMARY KEY (`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
CREATE UNIQUE INDEX `ac_languages_idx`
ON `ac_languages` ( `language_id`,`code` );
--
-- Dumping data for table `languages`
--

INSERT INTO `ac_languages` (`language_id`, `name`, `code`, `locale`, `image`, `directory`, `filename`, `sort_order`, `status`) VALUES
(1, 'فارسی', 'fa', 'fa_IR.UTF-8,fa_IR,persian', '', 'persian', 'persian', 1, 1);

--
-- DDL for table `language_definitions`
--
DROP TABLE IF EXISTS `ac_language_definitions`;
CREATE TABLE `ac_language_definitions` (
  `language_definition_id` int(11) NOT NULL auto_increment,
  `language_id` int(11) NOT NULL,
  `section` tinyint(1) NOT NULL default '0' COMMENT '0-SF, 1-ADMIN',
  `block` varchar(160) NOT NULL,
  `language_key` varchar(170) NOT NULL,
  `language_value` text NOT NULL COMMENT 'translatable',
  `date_added` timestamp NOT NULL default '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (`language_definition_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
CREATE UNIQUE INDEX `ac_lang_definition_idx`
ON `ac_language_definitions` ( `section`,`block`,`language_id`,`language_key` );

--
-- DDL for table `length_class`
--
DROP TABLE IF EXISTS `ac_length_classes`;
CREATE TABLE `ac_length_classes` (
  `length_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(15,8) NOT NULL,
  PRIMARY KEY (`length_class_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `length_class`
--

INSERT INTO `ac_length_classes` (`length_class_id`, `value`) VALUES
(1, '1.00000000'),
(2, '10.00000000'),
(3, '0.39370000');

--
-- DDL for table `length_class_descriptions`
--
DROP TABLE IF EXISTS `ac_length_class_descriptions`;
CREATE TABLE `ac_length_class_descriptions` (
  `length_class_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(32) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `unit` varchar(4) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`length_class_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `length_class_descriptions`
--

INSERT INTO `ac_length_class_descriptions` (`length_class_id`, `language_id`, `title`, `unit`) VALUES
(1, 1, 'سانتی متر', 'cm'),
(2, 1, 'میلیمتر', 'mm'),
(3, 1, 'اینچ', 'in');

--
-- DDL for table `manufacturers`
--
DROP TABLE IF EXISTS `ac_manufacturers`;
CREATE TABLE `ac_manufacturers` (
  `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`manufacturer_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;


--
-- DDL for table `manufacturers_to_store`
--
DROP TABLE IF EXISTS `ac_manufacturers_to_stores`;
CREATE TABLE `ac_manufacturers_to_stores` (
  `manufacturer_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`manufacturer_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `orders`
--
-- NOTE: If update table keep in mind ac_orders_enc
--
DROP TABLE IF EXISTS `ac_orders`;
CREATE TABLE `ac_orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL DEFAULT '0',
  `invoice_prefix` varchar(10) COLLATE utf8_general_ci NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `store_name` varchar(64) COLLATE utf8_general_ci NOT NULL,
  `store_url` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `customer_id` int(11) NOT NULL DEFAULT '0',
  `customer_group_id` int(11) NOT NULL DEFAULT '0',
  `firstname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `lastname` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `telephone` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fax` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` varchar(96) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shipping_firstname` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `shipping_lastname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shipping_company` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `shipping_address_1` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `shipping_address_2` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `shipping_city` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `shipping_postcode` varchar(10) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shipping_zone` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `shipping_zone_id` int(11) NOT NULL,
  `shipping_country` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `shipping_country_id` int(11) NOT NULL,
  `shipping_address_format` text COLLATE utf8_general_ci NOT NULL,
  `shipping_method` varchar(128) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shipping_method_key` varchar(128) NOT NULL DEFAULT '',
  `payment_firstname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `payment_lastname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `payment_company` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `payment_address_1` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `payment_address_2` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `payment_city` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `payment_postcode` varchar(10) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `payment_zone` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `payment_zone_id` int(11) NOT NULL,
  `payment_country` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `payment_country_id` int(11) NOT NULL,
  `payment_address_format` text COLLATE utf8_general_ci NOT NULL,
  `payment_method` varchar(128) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `payment_method_key` varchar(128) NOT NULL DEFAULT '',
  `comment` text COLLATE utf8_general_ci NOT NULL,
  `total` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `order_status_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `currency` varchar(3) COLLATE utf8_general_ci NOT NULL,
  `value` decimal(15,8) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip` varchar(15) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `payment_method_data` text COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`order_id`, `customer_id`, `order_status_id`)

) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_orders_idx`
ON `ac_orders` (`invoice_id`,
								`store_id`,
								`customer_group_id`,
								`shipping_zone_id`,
								`shipping_country_id`,
								`payment_zone_id`,
								`payment_country_id`,
								`language_id`,
								`currency_id`,
								`coupon_id`);
--
-- DDL for table `order_downloads`
--
DROP TABLE IF EXISTS `ac_order_downloads`;
CREATE TABLE `ac_order_downloads` (
  `order_download_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `order_product_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `filename` varchar(128) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mask` varchar(128) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `download_id` int(11) NOT NULL, 
  `status` int(1) NOT NULL DEFAULT '0',
  `remaining_count` int(11) DEFAULT NULL,
  `percentage` int(11) DEFAULT '0',
  `expire_date` datetime NULL,
  `sort_order` int(11) NOT NULL,
  `activate` VARCHAR(64) NOT NULL,
  `activate_order_status_id` int(11) NOT NULL DEFAULT '0', 
  `attributes_data` text COLLATE utf8_general_ci  DEFAULT NULL,  -- serialized values 
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', 
  PRIMARY KEY (`order_download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_order_downloads_idx`
ON `ac_order_downloads` (`order_id`, `order_product_id`, `download_id`, `status`, `activate_order_status_id`);
--
-- DDL for table `order_downloads`
--
DROP TABLE IF EXISTS `ac_order_downloads_history`;
CREATE TABLE `ac_order_downloads_history` (
  `order_download_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_download_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `order_product_id` int(11) NOT NULL,
  `filename` varchar(128) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mask` varchar(128) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `download_id` int(11) NOT NULL,
  `download_percent` int(11) DEFAULT '0',
  `time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_download_history_id`,`order_download_id`, `order_id`,`order_product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_order_downloads_history_idx`
ON `ac_order_downloads_history` (`download_id`);

--
-- DDL for table `ac_order_data`
-- Table to keep other order details (future dev)
--
DROP TABLE IF EXISTS `ac_order_data`;
CREATE TABLE `ac_order_data` (
  `order_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `data` text COLLATE utf8_general_ci DEFAULT NULL,  -- serialized values
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',  
  PRIMARY KEY (`order_id`, `type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `ac_order_data_types`;
CREATE TABLE `ac_order_data_types` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'translatable',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', 
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;


--
-- DDL for table `order_history`
--
DROP TABLE IF EXISTS `ac_order_history`;
CREATE TABLE `ac_order_history` (
  `order_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `order_status_id` int(5) NOT NULL,
  `notify` int(1) NOT NULL DEFAULT '0',
  `comment` text COLLATE utf8_general_ci NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', 
  PRIMARY KEY (`order_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_order_history_idx`
ON `ac_order_history` (`order_id`, `order_status_id`, `notify`);

--
-- DDL for table `order_options`
--
DROP TABLE IF EXISTS `ac_order_options`;
CREATE TABLE `ac_order_options` (
  `order_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `order_product_id` int(11) NOT NULL,
  `product_option_value_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `value` text COLLATE utf8_general_ci NOT NULL,
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `prefix` char(1) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `settings` text COLLATE utf8_general_ci,
  PRIMARY KEY (`order_option_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_order_options_idx`
ON `ac_order_options` (`order_id`, `order_product_id`, `product_option_value_id`);


--
-- DDL for table `order_products`
--
DROP TABLE IF EXISTS `ac_order_products`;
CREATE TABLE `ac_order_products` (
  `order_product_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `model` varchar(24) COLLATE utf8_general_ci NOT NULL,
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `total` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `tax` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `quantity` int(4) NOT NULL DEFAULT '0',
  `subtract` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_order_products_idx` ON `ac_order_products` (`order_id`,  `product_id`);

--
-- DDL for table `order_statuses`
--
DROP TABLE IF EXISTS `ac_order_statuses`;
CREATE TABLE `ac_order_statuses` (
  `order_status_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`order_status_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `order_statuses`
--

INSERT INTO `ac_order_statuses` (`order_status_id`, `language_id`, `name`) VALUES
(0, 1, 'ناقص'),
(1, 1, 'در حال بررسی'),
(2, 1, 'در حال پردازش'),
(3, 1, 'حمل'),
(7, 1, 'لغو شد'),
(5, 1, 'تکمیل'),
(8, 1, 'Denied'),
(9, 1, 'Canceled Reversal'),
(10, 1, 'شکست خورده'),
(11, 1, 'مسترد'),
(12, 1, 'معکوس'),
(13, 1, 'استرداد وجه');

--
-- DDL for table `order_totals`
--
DROP TABLE IF EXISTS `ac_order_totals`;
CREATE TABLE `ac_order_totals` (
  `order_total_id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `text` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `value` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `sort_order` int(3) NOT NULL,
  `type` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
   `key` varchar(128) NOT NULL DEFAULT '',
 PRIMARY KEY (`order_total_id`),
  KEY `idx_orders_total_orders_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;


--
-- DDL for table `products`
--
DROP TABLE IF EXISTS `ac_products`;
CREATE TABLE `ac_products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(64) COLLATE utf8_general_ci NOT NULL,
  `sku` varchar(64) COLLATE utf8_general_ci NOT NULL,
  `location` varchar(128) COLLATE utf8_general_ci NOT NULL,
  `quantity` int(4) NOT NULL DEFAULT '0',
  `stock_status_id` int(11) NOT NULL,
  `manufacturer_id` int(11) NOT NULL,
  `shipping` int(1) NOT NULL DEFAULT '1',
  `ship_individually` int(1) NOT NULL DEFAULT '0',
  `free_shipping` int(1) NOT NULL DEFAULT '0',
  `shipping_price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `tax_class_id` int(11) NOT NULL,
  `date_available` date NOT NULL,
  `weight` decimal(5,2) NOT NULL DEFAULT '0.00',
  `weight_class_id` int(11) NOT NULL DEFAULT '0',
  `length` decimal(5,2) NOT NULL DEFAULT '0.00',
  `width` decimal(5,2) NOT NULL DEFAULT '0.00',
  `height` decimal(5,2) NOT NULL DEFAULT '0.00',
  `length_class_id` int(11) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '0',
  `viewed` int(5) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `subtract` int(1) NOT NULL DEFAULT '1',
  `minimum` int(11) NOT NULL DEFAULT '1',
  `maximum` int(11) NOT NULL DEFAULT '0',
  `cost` DECIMAL(15,4) NOT NULL DEFAULT '0.0000',
  `call_to_order` smallint NOT NULL default '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', 
  PRIMARY KEY (`product_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_products_idx` ON `ac_products` (`stock_status_id`,  `manufacturer_id`, `weight_class_id`, `length_class_id`);


--
-- DDL for table `product_descriptions`
--
DROP TABLE IF EXISTS `ac_product_descriptions`;
CREATE TABLE `ac_product_descriptions` (
  `product_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `meta_keywords` varchar(255) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `meta_description` varchar(255) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `description` text COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `blurb` text COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`product_id`,`language_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;


--
-- DDL for table `product_discounts`
--
DROP TABLE IF EXISTS `ac_product_discounts`;
CREATE TABLE `ac_product_discounts` (
  `product_discount_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `quantity` int(4) NOT NULL DEFAULT '0',
  `priority` int(5) NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', 
  PRIMARY KEY (`product_discount_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_product_discounts_idx` ON `ac_product_discounts` (`product_id`, `customer_group_id`);


--
-- DDL for table `product_featured`
--
DROP TABLE IF EXISTS `ac_products_featured`;
CREATE TABLE `ac_products_featured` (
  `product_id` int(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `product_options`
--
DROP TABLE IF EXISTS `ac_product_options`;
CREATE TABLE `ac_product_options` (
  `product_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '1',
  `element_type` char(1) NOT NULL DEFAULT 'I',
  `required` smallint(1) NOT NULL default '0',
  `regexp_pattern` varchar(255) NOT NULL default '',
	`settings`			text COLLATE utf8_general_ci,
  PRIMARY KEY (`product_option_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_product_options_idx` ON `ac_product_options` (`attribute_id`, `product_id`, `group_id` );

--
-- DDL for table `product_option_descriptions`
--
DROP TABLE IF EXISTS `ac_product_option_descriptions`;
CREATE TABLE `ac_product_option_descriptions` (
  `product_option_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `option_placeholder` varchar(255) COLLATE utf8_general_ci DEFAULT '' COMMENT 'translatable',
  `error_text` 	varchar(255) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`product_option_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
CREATE INDEX `ac_product_option_descriptions_idx` ON `ac_product_option_descriptions` ( `product_id` );
--
-- DDL for table `product_option_values`
--
DROP TABLE IF EXISTS `ac_product_option_values`;
CREATE TABLE `ac_product_option_values` (
  `product_option_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_option_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '0',
  `sku` varchar(255) DEFAULT NULL,
  `quantity` int(4) NOT NULL DEFAULT '0',
  `subtract` int(1) NOT NULL DEFAULT '0',
  `price` decimal(15,4) NOT NULL,
  `prefix` char(1) COLLATE utf8_general_ci NOT NULL, -- % or $ 
  `weight` decimal(15,8) NOT NULL,
  `weight_type` varchar(3) COLLATE utf8_general_ci NOT NULL, -- lbs or %
  `attribute_value_id` int(11),  
  `grouped_attribute_data` text DEFAULT NULL,
  `sort_order` int(3) NOT NULL,
  `default` smallint DEFAULT 0,
  PRIMARY KEY (`product_option_value_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_product_option_values_idx` ON `ac_product_option_values` ( `product_option_id`, `product_id`, `group_id`, `attribute_value_id` );


--
-- DDL for table `product_option_value_descriptions`
--
DROP TABLE IF EXISTS `ac_product_option_value_descriptions`;
CREATE TABLE `ac_product_option_value_descriptions` (
  `product_option_value_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` text COLLATE utf8_general_ci DEFAULT NULL COMMENT 'translatable',
  `grouped_attribute_names` text COLLATE utf8_general_ci DEFAULT NULL,  
  PRIMARY KEY (`product_option_value_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
CREATE INDEX `ac_product_option_value_descriptions_idx` ON `ac_product_option_value_descriptions` ( `product_id` );

--
-- DDL for table `product_related`
--
DROP TABLE IF EXISTS `ac_products_related`;
CREATE TABLE `ac_products_related` (
  `product_id` int(11) NOT NULL,
  `related_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`related_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `product_specials`
--
DROP TABLE IF EXISTS `ac_product_specials`;
CREATE TABLE `ac_product_specials` (
  `product_special_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `priority` int(5) NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`product_special_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_product_specials_idx` ON `ac_product_specials` ( `product_id`, `customer_group_id` );

--
-- DDL for table `product_tags`
--
DROP TABLE IF EXISTS `ac_product_tags`;
CREATE TABLE `ac_product_tags` (
  `product_id` int(11) NOT NULL,
  `tag` varchar(32) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `language_id` int(11) NOT NULL,
  PRIMARY KEY  (`product_id`,`tag`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `product_to_categories`
--
DROP TABLE IF EXISTS `ac_products_to_categories`;
CREATE TABLE `ac_products_to_categories` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `product_to_downloads`
--
DROP TABLE IF EXISTS `ac_products_to_downloads`;
CREATE TABLE `ac_products_to_downloads` (
  `product_id` int(11) NOT NULL,
  `download_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`download_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `product_to_stores`
--
DROP TABLE IF EXISTS `ac_products_to_stores`;
CREATE TABLE `ac_products_to_stores` (
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`product_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `reviews`
--
DROP TABLE IF EXISTS `ac_reviews`;
CREATE TABLE `ac_reviews` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `author` varchar(64) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `text` text COLLATE utf8_general_ci NOT NULL,
  `rating` int(1) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`review_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_reviews_idx` ON `ac_reviews` ( `product_id`, `customer_id` );


--
-- DDL for table `settings`
--
DROP TABLE IF EXISTS `ac_settings`;
CREATE TABLE `ac_settings` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL DEFAULT 0,
  `group` varchar(32) COLLATE utf8_general_ci NOT NULL,
  `key` varchar(64) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `value` text COLLATE utf8_general_ci NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
 PRIMARY KEY (`setting_id`,`store_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `settings`
--

INSERT INTO `ac_settings` (`group`, `key`, `value`) VALUES

-- details of store
('details','store_name','Web Store Name'),
('details','config_url',''),
('details','config_ssl',0),
('details','config_ssl_url',''),
('details','config_owner','Your Name'),
('details','config_address','Address 1'),
('details','store_main_email','admin@abantecart.com'),
('details','config_telephone',123456789),
('details','config_fax',''),
('details','config_title','Your Store'),
('details','config_meta_description','Web Store Meta Description'),
('details','config_meta_keywords','keyword1,keyword2,keyword3'),
('details','config_description_1','Welcome to web store!'),
('details','config_country_id',101),
('details','config_zone_id',1543),
('details','config_storefront_language','fa'),
('details','admin_language','fa'),
('details','config_currency','ریال'),
('details','config_currency_auto',0),
('details','config_length_class','cm'),
('details','config_weight_class','kg'),
('details','auto_translate_status',1),
('details','translate_src_lang_code','en'),
('details','translate_override_existing',0),
('details','warn_lang_text_missing',0),
('details','config_description_9','Welcome to web store!'),
-- general
('general','config_admin_limit',20),
('general','config_catalog_limit',20),
('general','config_bestseller_limit',4),
('general','config_featured_limit',4),
('general','config_latest_limit',4),
('general','config_special_limit',4),
('general','config_stock_display',1),
('general','config_nostock_autodisable',0),
('general','config_stock_status_id',5),
('general','enable_reviews',1),
('general','config_download',1),
('general','config_help_links',1),
('general','config_show_tree_data',1),
('general','config_embed_status',1),
('general','config_embed_click_action', 'modal'),
('general','config_product_default_sort_order','date_modified-ASC'),
-- Checkout
('checkout','starting_invoice_id',001),
('checkout','invoice_prefix','IN#'),
('checkout','config_cart_weight',0),
('checkout','config_shipping_session',0),
('checkout','config_tax', 0),
('checkout','config_tax_store',1),
('checkout','config_tax_customer',0),
('checkout','config_customer_price',1),
('checkout','config_customer_group_id',1),
('checkout','config_customer_approval',0),
('checkout','config_customer_email_activation',0),
('checkout','prevent_email_as_login',1),
('checkout','config_guest_checkout',1),
('checkout','config_account_id',2),
('checkout','config_checkout_id',3),
('checkout','config_stock_checkout',0),
('checkout','config_order_status_id',1),
('checkout','config_stock_subtract',0),
('checkout','config_stock_check',1),
('checkout','config_cart_ajax',1),
('checkout','total_order_maximum',0),
('checkout','total_order_minimum',0),
('checkout','config_shipping_tax_estimate',1),
('checkout','config_coupon_on_cart_page',1),

-- Appearance

('appearance','storefront_width','100%'),
('appearance','config_logo','image/18/73/3.png'),
('appearance','config_icon','image/18/73/4.ico'),
('appearance','config_image_thumb_width',380),
('appearance','config_image_thumb_height',380),
('appearance','config_image_popup_width',500),
('appearance','config_image_popup_height',500),
('appearance','config_image_product_width',250),
('appearance','config_image_product_height',250),
('appearance','config_image_additional_width',45),
('appearance','config_image_additional_height',45),
('appearance','config_image_related_width',120),
('appearance','config_image_related_height',120),
('appearance','config_image_cart_width',75),
('appearance','config_image_cart_height',75),
('appearance','config_image_grid_width',57),
('appearance','config_image_grid_height',57),
('appearance','config_image_category_height',120),
('appearance','config_image_category_width',120),
('appearance','admin_template','default'),
('appearance','admin_width','100%'),
('appearance','config_storefront_template','default'),


-- mail
('mail', 'config_mail_protocol', 'mail'),
('mail', 'config_mail_parameter', ''),
('mail', 'config_smtp_host', ''),
('mail', 'config_smtp_username', ''),
('mail', 'config_smtp_password', ''),
('mail', 'config_smtp_port', '25'),
('mail', 'config_smtp_timeout', '5'),
('mail', 'config_alert_mail', '0'),
('mail', 'config_alert_emails', ''),

-- system
	('system','config_session_ttl',120),
	('system','config_maintenance',0),
	('system','encryption_key',12345),
	('system','enable_seo_url',0),
	('system','config_retina_enable',0),
	('system','config_compression',0),
	('system','config_cache_enable',1),
	('system','config_error_display',1),
	('system','config_error_log',1),
	('system','config_debug',0),
	('system','config_debug_level',0),
	('system','storefront_template_debug',0),
	('system','config_error_filename','error.txt'),
	('system','config_upload_max_size',16000),
	('system','config_voicecontrol', 1),

-- API
    ('api','config_storefront_api_status', '0'),
    ('api','config_storefront_api_key',''),
    ('api','config_storefront_api_stock_check',0),
    ('api','config_admin_api_status',0),
    ('api','config_admin_api_key',''),
    ('api','config_admin_access_ip_list',''),

-- EXTENSIONS
('sub_total', 'sub_total_sort_order', '1'),
('sub_total', 'sub_total_calculation_order', '1'),
('sub_total', 'sub_total_status', '1'),
('sub_total', 'sub_total_total_type', 'subtotal'),

('shipping', 'shipping_sort_order', '3'),
('shipping', 'shipping_calculation_order', '3'),
('shipping', 'shipping_status', '1'),
('shipping', 'shipping_total_type', 'shipping'),


('coupon','coupon_status',1),
('coupon','coupon_sort_order',4),
('coupon','coupon_calculation_order',4),
('coupon','coupon_total_type','discount'),

('tax', 'tax_status', '1'),
('tax', 'tax_sort_order', '5'),
('tax', 'tax_calculation_order', '5'),
('tax', 'tax_total_type', 'tax'),

('balance', 'balance_status', '1'),
('balance', 'balance_sort_order', '6'),
('balance', 'balance_calculation_order', '6'),
('balance', 'balance_total_type', 'balance'),

('total', 'total_sort_order', '7'),
('total', 'total_calculation_order', '7'),
('total', 'total_status', '1'),
('total', 'total_total_type', 'total'),

('banner_manager','banner_manager_layout',''),
('banner_manager','banner_manager_priority',10),
('banner_manager','banner_manager_date_installed', NOW()),
('banner_manager','store_id',0),
('banner_manager','banner_manager_status',1),

('forms_manager','forms_manager_priority',10),
('forms_manager','forms_manager_date_installed', NOW()),
('forms_manager','store_id',0),
('forms_manager','forms_manager_status',1),
('forms_manager','forms_manager_default_sender_name', ''),
('forms_manager','forms_manager_default_sender_email', ''),
('forms_manager','forms_manager_sort_order', '')
;


--
-- DDL for table `stock_statuses`
--
DROP TABLE IF EXISTS `ac_stock_statuses`;
CREATE TABLE `ac_stock_statuses` (
  `stock_status_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`stock_status_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `stock_status`
--

INSERT INTO `ac_stock_statuses` (`stock_status_id`, `language_id`, `name`) VALUES
(1, 1, 'در انبار'),
(2, 1, 'تمام شده'),
(3, 1, 'پیش سفارش');

--
-- DDL for table `stores`
--
DROP TABLE IF EXISTS `ac_stores`;
CREATE TABLE `ac_stores` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_general_ci NOT NULL,
  `alias` varchar(15) COLLATE utf8_general_ci NOT NULL,
  `status` int(1) NOT NULL,
   PRIMARY KEY (`store_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=0;

INSERT INTO `ac_stores` VALUES	(0,'default','default',1);

--
-- DDL for table `store_descriptions`
--
DROP TABLE IF EXISTS `ac_store_descriptions`;
CREATE TABLE `ac_store_descriptions` (
  `store_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `description` text COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`store_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `tax_classes`
--
DROP TABLE IF EXISTS `ac_tax_classes`;
CREATE TABLE `ac_tax_classes` (
  `tax_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tax_class_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `tax_class`
--

INSERT INTO `ac_tax_classes` (`tax_class_id`, `date_added`) VALUES (1, now());

--
-- DDL for table `tax_class_descriptions`
--
DROP TABLE IF EXISTS `ac_tax_class_descriptions`;
CREATE TABLE `ac_tax_class_descriptions` (
  `tax_class_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(128) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `description` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'translatable',
  PRIMARY KEY (`tax_class_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_tax_class_descriptions` (`tax_class_id`, `language_id`, `title`, `description`) VALUES (1, 1, 'Taxable Goods', 'Taxed Products');

--
-- DDL for table `tax_rates`
--
DROP TABLE IF EXISTS `ac_tax_rates`;
CREATE TABLE `ac_tax_rates` (
  `tax_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL DEFAULT '0',
  `zone_id` int(11) DEFAULT '0',
  `tax_class_id` int(11) NOT NULL,
  `priority` int(5) NOT NULL DEFAULT '1',
  `rate` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `rate_prefix` char(1) COLLATE utf8_general_ci NOT NULL DEFAULT '%', -- % or $ 
  `threshold_condition` char(2) COLLATE utf8_general_ci NOT NULL, -- '<=', '>=', '==' or '<'
  `threshold` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tax_rate_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_tax_rates_idx` ON `ac_tax_rates` ( `location_id`, `zone_id`, `tax_class_id` );
--
-- Dumping data for table `tax_rate`
--
INSERT INTO `ac_tax_rates` (`tax_rate_id`, `location_id`, `tax_class_id`, `priority`, `rate`) VALUES (1, 1, 1, 1, '8.5000');

--
-- DDL for table `tax_rate_descriptions`
--

DROP TABLE IF EXISTS `ac_tax_rate_descriptions`;
CREATE TABLE `ac_tax_rate_descriptions` (
  `tax_rate_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'translatable',
  PRIMARY KEY (`tax_rate_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tax_rate_descriptions`
--

INSERT INTO `ac_tax_rate_descriptions` (`tax_rate_id`, `language_id`, `description`) VALUES (1, 1, 'Retail 8.5%');

--
-- DDL for table `url_alias`
--
DROP TABLE IF EXISTS `ac_url_aliases`;
CREATE TABLE `ac_url_aliases` (
  `url_alias_id` int(11) NOT NULL AUTO_INCREMENT,
  `query` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `keyword` varchar(255) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `language_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`url_alias_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
CREATE UNIQUE INDEX `ac_url_aliases_idx`
ON `ac_url_aliases` ( `keyword`, `language_id`);
CREATE UNIQUE INDEX `ac_url_aliases_idx2`
ON `ac_url_aliases` ( `query`, `language_id` );


--
-- DDL for table `user`
--
DROP TABLE IF EXISTS `ac_users`;
CREATE TABLE `ac_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_group_id` int(11) NOT NULL,
  `username` varchar(20) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `firstname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `lastname` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` varchar(96) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` int(1) NOT NULL,
  `ip` varchar(15) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `last_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=2;



--
-- DDL for table `user_group`
--
DROP TABLE IF EXISTS `ac_user_groups`;
CREATE TABLE `ac_user_groups` (
  `user_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_general_ci NOT NULL,
  `permission` text COLLATE utf8_general_ci NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `user_group`
--

INSERT INTO `ac_user_groups` (`user_group_id`, `name`, `permission`) VALUES
(1, 'مدیر ارشد', ''),
(10, 'Demonstration', '');

--
-- DDL for table `weight_class`
--
DROP TABLE IF EXISTS `ac_weight_classes`;
CREATE TABLE `ac_weight_classes` (
  `weight_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  PRIMARY KEY (`weight_class_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `weight_class`
--

INSERT INTO `ac_weight_classes` (`weight_class_id`, `value`) VALUES
(1, '1.00000000'),
(2, '1000.00000000'),
(5, '2.20460000'),
(6, '35.27400000');


--
-- DDL for table `weight_class_description`
--
DROP TABLE IF EXISTS `ac_weight_class_descriptions`;
CREATE TABLE `ac_weight_class_descriptions` (
  `weight_class_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(32) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `unit` varchar(4) COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'translatable',
  PRIMARY KEY (`weight_class_id`,`language_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `weight_class_description`
--

INSERT INTO `ac_weight_class_descriptions` (`weight_class_id`, `language_id`, `title`, `unit`) VALUES
(1, 1, 'کیلو گرم', 'kg'),
(2, 1, 'گرم', 'g'),
(5, 1, 'پوند', 'lb'),
(6, 1, 'اونس', 'oz');

--
-- DDL for table `zone`
--
DROP TABLE IF EXISTS `ac_zones`;
CREATE TABLE `ac_zones` (
  `zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `code` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT '1',
  `sort_order` int(3) NOT NULL DEFAULT '0',  
  PRIMARY KEY (`zone_id`, `country_id` )
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `zone`
--

INSERT INTO `ac_zones` (`zone_id`, `country_id`, `code`, `status`, `sort_order`) VALUES
(1538,101,'TEH',1,0),
(1539,101,'QOM',1,0),
(1540,101,'MKZ',1,0),
(1541,101,'QAZ',1,0),
(1542,101,'GIL',1,0),
(1543,101,'ARD',1,0),
(1544,101,'ZAN',1,0),
(1545,101,'EAZ',1,0),
(1546,101,'WEZ',1,0),
(1547,101,'KRD',1,0),
(1548,101,'HMD',1,0),
(1549,101,'KRM',1,0),
(1550,101,'ILM',1,0),
(1551,101,'LRS',1,0),
(1552,101,'KZT',1,0),
(1553,101,'CMB',1,0),
(1554,101,'KBA',1,0),
(1555,101,'BSH',1,0),
(1556,101,'FAR',1,0),
(1557,101,'HRM',1,0),
(1558,101,'SBL',1,0),
(1559,101,'KRB',1,0),
(1560,101,'YZD',1,0),
(1561,101,'EFH',1,0),
(1562,101,'SMN',1,0),
(1563,101,'MZD',1,0),
(1564,101,'GLS',1,0),
(1565,101,'NKH',1,0),
(1566,101,'RKH',1,0),
(1567,101,'SKH',1,0);


DROP TABLE IF EXISTS `ac_zone_descriptions`;
CREATE TABLE `ac_zone_descriptions` (
  `zone_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`zone_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `ac_zone_descriptions` (`zone_id`, `language_id`,`name`) VALUES 
(1,1,'Badakhshan'),
(2,1,'Badghis'),
(3,1,'Baghlan'),
(4,1,'Balkh'),
(5,1,'Bamian'),
(6,1,'Farah'),
(7,1,'Faryab'),
(8,1,'Ghazni'),
(9,1,'Ghowr'),
(10,1,'Helmand'),
(11,1,'Herat'),
(12,1,'Jowzjan'),
(13,1,'Kabul'),
(14,1,'Kandahar'),
(15,1,'Kapisa'),
(16,1,'Khost'),
(17,1,'Konar'),
(18,1,'Kondoz'),
(19,1,'Laghman'),
(20,1,'Lowgar'),
(21,1,'Nangrahar'),
(22,1,'Nimruz'),
(23,1,'Nurestan'),
(24,1,'Oruzgan'),
(25,1,'Paktia'),
(26,1,'Paktika'),
(27,1,'Parwan'),
(28,1,'Samangan'),
(29,1,'Sar-e Pol'),
(30,1,'Takhar'),
(31,1,'Wardak'),
(32,1,'Zabol'),
(33,1,'Berat'),
(34,1,'Bulqize'),
(35,1,'Delvine'),
(36,1,'Devoll'),
(37,1,'Diber'),
(38,1,'Durres'),
(39,1,'Elbasan'),
(40,1,'Kolonje'),
(41,1,'Fier'),
(42,1,'Gjirokaster'),
(43,1,'Gramsh'),
(44,1,'Has'),
(45,1,'Kavaje'),
(46,1,'Kurbin'),
(47,1,'Kucove'),
(48,1,'Korce'),
(49,1,'Kruje'),
(50,1,'Kukes'),
(51,1,'Librazhd'),
(52,1,'Lezhe'),
(53,1,'Lushnje'),
(54,1,'Malesi e Madhe'),
(55,1,'Mallakaster'),
(56,1,'Mat'),
(57,1,'Mirdite'),
(58,1,'Peqin'),
(59,1,'Permet'),
(60,1,'Pogradec'),
(61,1,'Puke'),
(62,1,'Shkoder'),
(63,1,'Skrapar'),
(64,1,'Sarande'),
(65,1,'Tepelene'),
(66,1,'Tropoje'),
(67,1,'Tirane'),
(68,1,'Vlore'),
(69,1,'Adrar'),
(70,1,'Ain Defla'),
(71,1,'Ain Temouchent'),
(72,1,'Alger'),
(73,1,'Annaba'),
(74,1,'Batna'),
(75,1,'Bechar'),
(76,1,'Bejaia'),
(77,1,'Biskra'),
(78,1,'Blida'),
(79,1,'Bordj Bou Arreridj'),
(80,1,'Bouira'),
(81,1,'Boumerdes'),
(82,1,'Chlef'),
(83,1,'Constantine'),
(84,1,'Djelfa'),
(85,1,'El Bayadh'),
(86,1,'El Oued'),
(87,1,'El Tarf'),
(88,1,'Ghardaia'),
(89,1,'Guelma'),
(90,1,'Illizi'),
(91,1,'Jijel'),
(92,1,'Khenchela'),
(93,1,'Laghouat'),
(94,1,'Muaskar'),
(95,1,'Medea'),
(96,1,'Mila'),
(97,1,'Mostaganem'),
(98,1,'M\'Sila'),
(99,1,'Naama'),
(100,1,'Oran'),
(101,1,'Ouargla'),
(102,1,'Oum el-Bouaghi'),
(103,1,'Relizane'),
(104,1,'Saida'),
(105,1,'Setif'),
(106,1,'Sidi Bel Abbes'),
(107,1,'Skikda'),
(108,1,'Souk Ahras'),
(109,1,'Tamanghasset'),
(110,1,'Tebessa'),
(111,1,'Tiaret'),
(112,1,'Tindouf'),
(113,1,'Tipaza'),
(114,1,'Tissemsilt'),
(115,1,'Tizi Ouzou'),
(116,1,'Tlemcen'),
(117,1,'Eastern'),
(118,1,'Manu\'a'),
(119,1,'Rose Island'),
(120,1,'Swains Island'),
(121,1,'Western'),
(122,1,'Andorra la Vella'),
(123,1,'Canillo'),
(124,1,'Encamp'),
(125,1,'Escaldes-Engordany'),
(126,1,'La Massana'),
(127,1,'Ordino'),
(128,1,'Sant Julia de Loria'),
(129,1,'Bengo'),
(130,1,'Benguela'),
(131,1,'Bie'),
(132,1,'Cabinda'),
(133,1,'Cuando-Cubango'),
(134,1,'Cuanza Norte'),
(135,1,'Cuanza Sul'),
(136,1,'Cunene'),
(137,1,'Huambo'),
(138,1,'Huila'),
(139,1,'Luanda'),
(140,1,'Lunda Norte'),
(141,1,'Lunda Sul'),
(142,1,'Malange'),
(143,1,'Moxico'),
(144,1,'Namibe'),
(145,1,'Uige'),
(146,1,'Zaire'),
(147,1,'Saint George'),
(148,1,'Saint John'),
(149,1,'Saint Mary'),
(150,1,'Saint Paul'),
(151,1,'Saint Peter'),
(152,1,'Saint Philip'),
(153,1,'Barbuda'),
(154,1,'Redonda'),
(155,1,'Antartida e Islas del Atlantico'),
(156,1,'Buenos Aires'),
(157,1,'Catamarca'),
(158,1,'Chaco'),
(159,1,'Chubut'),
(160,1,'Cordoba'),
(161,1,'Corrientes'),
(162,1,'Distrito Federal'),
(163,1,'Entre Rios'),
(164,1,'Formosa'),
(165,1,'Jujuy'),
(166,1,'La Pampa'),
(167,1,'La Rioja'),
(168,1,'Mendoza'),
(169,1,'Misiones'),
(170,1,'Neuquen'),
(171,1,'Rio Negro'),
(172,1,'Salta'),
(173,1,'San Juan'),
(174,1,'San Luis'),
(175,1,'Santa Cruz'),
(176,1,'Santa Fe'),
(177,1,'Santiago del Estero'),
(178,1,'Tierra del Fuego'),
(179,1,'Tucuman'),
(180,1,'Aragatsotn'),
(181,1,'Ararat'),
(182,1,'Armavir'),
(183,1,'Geghark\'unik\''),
(184,1,'Kotayk\''),
(185,1,'Lorri'),
(186,1,'Shirak'),
(187,1,'Syunik\''),
(188,1,'Tavush'),
(189,1,'Vayots\' Dzor'),
(190,1,'Yerevan'),
(191,1,'Australian Capital Territory'),
(192,1,'New South Wales'),
(193,1,'Northern Territory'),
(194,1,'Queensland'),
(195,1,'South Australia'),
(196,1,'Tasmania'),
(197,1,'Victoria'),
(198,1,'Western Australia'),
(199,1,'Burgenland'),
(200,1,'Kärnten'),
(201,1,'Nieder&ouml;sterreich'),
(202,1,'Ober&ouml;sterreich'),
(203,1,'Salzburg'),
(204,1,'Steiermark'),
(205,1,'Tirol'),
(206,1,'Vorarlberg'),
(207,1,'Wien'),
(208,1,'Ali Bayramli'),
(209,1,'Abseron'),
(210,1,'AgcabAdi'),
(211,1,'Agdam'),
(212,1,'Agdas'),
(213,1,'Agstafa'),
(214,1,'Agsu'),
(215,1,'Astara'),
(216,1,'Baki'),
(217,1,'BabAk'),
(218,1,'BalakAn'),
(219,1,'BArdA'),
(220,1,'Beylaqan'),
(221,1,'Bilasuvar'),
(222,1,'Cabrayil'),
(223,1,'Calilabab'),
(224,1,'Culfa'),
(225,1,'Daskasan'),
(226,1,'Davaci'),
(227,1,'Fuzuli'),
(228,1,'Ganca'),
(229,1,'Gadabay'),
(230,1,'Goranboy'),
(231,1,'Goycay'),
(232,1,'Haciqabul'),
(233,1,'Imisli'),
(234,1,'Ismayilli'),
(235,1,'Kalbacar'),
(236,1,'Kurdamir'),
(237,1,'Lankaran'),
(238,1,'Lacin'),
(239,1,'Lankaran'),
(240,1,'Lerik'),
(241,1,'Masalli'),
(242,1,'Mingacevir'),
(243,1,'Naftalan'),
(244,1,'Neftcala'),
(245,1,'Oguz'),
(246,1,'Ordubad'),
(247,1,'Qabala'),
(248,1,'Qax'),
(249,1,'Qazax'),
(250,1,'Qobustan'),
(251,1,'Quba'),
(252,1,'Qubadli'),
(253,1,'Qusar'),
(254,1,'Saki'),
(255,1,'Saatli'),
(256,1,'Sabirabad'),
(257,1,'Sadarak'),
(258,1,'Sahbuz'),
(259,1,'Saki'),
(260,1,'Salyan'),
(261,1,'Sumqayit'),
(262,1,'Samaxi'),
(263,1,'Samkir'),
(264,1,'Samux'),
(265,1,'Sarur'),
(266,1,'Siyazan'),
(267,1,'Susa'),
(268,1,'Susa'),
(269,1,'Tartar'),
(270,1,'Tovuz'),
(271,1,'Ucar'),
(272,1,'Xankandi'),
(273,1,'Xacmaz'),
(274,1,'Xanlar'),
(275,1,'Xizi'),
(276,1,'Xocali'),
(277,1,'Xocavand'),
(278,1,'Yardimli'),
(279,1,'Yevlax'),
(280,1,'Zangilan'),
(281,1,'Zaqatala'),
(282,1,'Zardab'),
(283,1,'Naxcivan'),
(284,1,'Acklins'),
(285,1,'Berry Islands'),
(286,1,'Bimini'),
(287,1,'Black Point'),
(288,1,'Cat Island'),
(289,1,'Central Abaco'),
(290,1,'Central Andros'),
(291,1,'Central Eleuthera'),
(292,1,'City of Freeport'),
(293,1,'Crooked Island'),
(294,1,'East Grand Bahama'),
(295,1,'Exuma'),
(296,1,'Grand Cay'),
(297,1,'Harbour Island'),
(298,1,'Hope Town'),
(299,1,'Inagua'),
(300,1,'Long Island'),
(301,1,'Mangrove Cay'),
(302,1,'Mayaguana'),
(303,1,'Moore\'s Island'),
(304,1,'North Abaco'),
(305,1,'North Andros'),
(306,1,'North Eleuthera'),
(307,1,'Ragged Island'),
(308,1,'Rum Cay'),
(309,1,'San Salvador'),
(310,1,'South Abaco'),
(311,1,'South Andros'),
(312,1,'South Eleuthera'),
(313,1,'Spanish Wells'),
(314,1,'West Grand Bahama'),
(315,1,'Capital'),
(316,1,'Central'),
(317,1,'Muharraq'),
(318,1,'Northern'),
(319,1,'Southern'),
(320,1,'Barisal'),
(321,1,'Chittagong'),
(322,1,'Dhaka'),
(323,1,'Khulna'),
(324,1,'Rajshahi'),
(325,1,'Sylhet'),
(326,1,'Christ Church'),
(327,1,'Saint Andrew'),
(328,1,'Saint George'),
(329,1,'Saint James'),
(330,1,'Saint John'),
(331,1,'Saint Joseph'),
(332,1,'Saint Lucy'),
(333,1,'Saint Michael'),
(334,1,'Saint Peter'),
(335,1,'Saint Philip'),
(336,1,'Saint Thomas'),
(337,1,'Brestskaya (Brest)'),
(338,1,'Homyel\'skaya (Homyel\')'),
(339,1,'Horad Minsk'),
(340,1,'Hrodzyenskaya (Hrodna)'),
(341,1,'Mahilyowskaya (Mahilyow)'),
(342,1,'Minskaya'),
(343,1,'Vitsyebskaya (Vitsyebsk)'),
(344,1,'Antwerpen'),
(345,1,'Brabant Wallon'),
(346,1,'Hainaut'),
(347,1,'Liege'),
(348,1,'Limburg'),
(349,1,'Luxembourg'),
(350,1,'Namur'),
(351,1,'Oost-Vlaanderen'),
(352,1,'Vlaams Brabant'),
(353,1,'West-Vlaanderen'),
(354,1,'Belize'),
(355,1,'Cayo'),
(356,1,'Corozal'),
(357,1,'Orange Walk'),
(358,1,'Stann Creek'),
(359,1,'Toledo'),
(360,1,'Alibori'),
(361,1,'Atakora'),
(362,1,'Atlantique'),
(363,1,'Borgou'),
(364,1,'Collines'),
(365,1,'Donga'),
(366,1,'Kouffo'),
(367,1,'Littoral'),
(368,1,'Mono'),
(369,1,'Oueme'),
(370,1,'Plateau'),
(371,1,'Zou'),
(372,1,'Devonshire'),
(373,1,'Hamilton City'),
(374,1,'Hamilton'),
(375,1,'Paget'),
(376,1,'Pembroke'),
(377,1,'Saint George City'),
(378,1,'Saint George\'s'),
(379,1,'Sandys'),
(380,1,'Smith\'s'),
(381,1,'Southampton'),
(382,1,'Warwick'),
(383,1,'Bumthang'),
(384,1,'Chukha'),
(385,1,'Dagana'),
(386,1,'Gasa'),
(387,1,'Haa'),
(388,1,'Lhuntse'),
(389,1,'Mongar'),
(390,1,'Paro'),
(391,1,'Pemagatshel'),
(392,1,'Punakha'),
(393,1,'Samdrup Jongkhar'),
(394,1,'Samtse'),
(395,1,'Sarpang'),
(396,1,'Thimphu'),
(397,1,'Trashigang'),
(398,1,'Trashiyangste'),
(399,1,'Trongsa'),
(400,1,'Tsirang'),
(401,1,'Wangdue Phodrang'),
(402,1,'Zhemgang'),
(403,1,'Beni'),
(404,1,'Chuquisaca'),
(405,1,'Cochabamba'),
(406,1,'La Paz'),
(407,1,'Oruro'),
(408,1,'Pando'),
(409,1,'Potosi'),
(410,1,'Santa Cruz'),
(411,1,'Tarija'),
(412,1,'Brcko district'),
(413,1,'Unsko-Sanski Kanton'),
(414,1,'Posavski Kanton'),
(415,1,'Tuzlanski Kanton'),
(416,1,'Zenicko-Dobojski Kanton'),
(417,1,'Bosanskopodrinjski Kanton'),
(418,1,'Srednjebosanski Kanton'),
(419,1,'Hercegovacko-neretvanski Kanton'),
(420,1,'Zapadnohercegovacka Zupanija'),
(421,1,'Kanton Sarajevo'),
(422,1,'Zapadnobosanska'),
(423,1,'Banja Luka'),
(424,1,'Doboj'),
(425,1,'Bijeljina'),
(426,1,'Vlasenica'),
(427,1,'Sarajevo-Romanija or Sokolac'),
(428,1,'Foca'),
(429,1,'Trebinje'),
(430,1,'Central'),
(431,1,'Ghanzi'),
(432,1,'Kgalagadi'),
(433,1,'Kgatleng'),
(434,1,'Kweneng'),
(435,1,'Ngamiland'),
(436,1,'North East'),
(437,1,'North West'),
(438,1,'South East'),
(439,1,'Southern'),
(440,1,'Acre'),
(441,1,'Alagoas'),
(442,1,'Amapa'),
(443,1,'Amazonas'),
(444,1,'Bahia'),
(445,1,'Ceara'),
(446,1,'Distrito Federal'),
(447,1,'Espirito Santo'),
(448,1,'Goias'),
(449,1,'Maranhao'),
(450,1,'Mato Grosso'),
(451,1,'Mato Grosso do Sul'),
(452,1,'Minas Gerais'),
(453,1,'Para'),
(454,1,'Paraiba'),
(455,1,'Parana'),
(456,1,'Pernambuco'),
(457,1,'Piaui'),
(458,1,'Rio de Janeiro'),
(459,1,'Rio Grande do Norte'),
(460,1,'Rio Grande do Sul'),
(461,1,'Rondonia'),
(462,1,'Roraima'),
(463,1,'Santa Catarina'),
(464,1,'Sao Paulo'),
(465,1,'Sergipe'),
(466,1,'Tocantins'),
(467,1,'Peros Banhos'),
(468,1,'Salomon Islands'),
(469,1,'Nelsons Island'),
(470,1,'Three Brothers'),
(471,1,'Eagle Islands'),
(472,1,'Danger Island'),
(473,1,'Egmont Islands'),
(474,1,'Diego Garcia'),
(475,1,'Belait'),
(476,1,'Brunei and Muara'),
(477,1,'Temburong'),
(478,1,'Tutong'),
(479,1,'Blagoevgrad'),
(480,1,'Burgas'),
(481,1,'Dobrich'),
(482,1,'Gabrovo'),
(483,1,'Haskovo'),
(484,1,'Kardjali'),
(485,1,'Kyustendil'),
(486,1,'Lovech'),
(487,1,'Montana'),
(488,1,'Pazardjik'),
(489,1,'Pernik'),
(490,1,'Pleven'),
(491,1,'Plovdiv'),
(492,1,'Razgrad'),
(493,1,'Shumen'),
(494,1,'Silistra'),
(495,1,'Sliven'),
(496,1,'Smolyan'),
(497,1,'Sofia'),
(498,1,'Sofia - town'),
(499,1,'Stara Zagora'),
(500,1,'Targovishte'),
(501,1,'Varna'),
(502,1,'Veliko Tarnovo'),
(503,1,'Vidin'),
(504,1,'Vratza'),
(505,1,'Yambol'),
(506,1,'Bale'),
(507,1,'Bam'),
(508,1,'Banwa'),
(509,1,'Bazega'),
(510,1,'Bougouriba'),
(511,1,'Boulgou'),
(512,1,'Boulkiemde'),
(513,1,'Comoe'),
(514,1,'Ganzourgou'),
(515,1,'Gnagna'),
(516,1,'Gourma'),
(517,1,'Houet'),
(518,1,'Ioba'),
(519,1,'Kadiogo'),
(520,1,'Kenedougou'),
(521,1,'Komondjari'),
(522,1,'Kompienga'),
(523,1,'Kossi'),
(524,1,'Koulpelogo'),
(525,1,'Kouritenga'),
(526,1,'Kourweogo'),
(527,1,'Leraba'),
(528,1,'Loroum'),
(529,1,'Mouhoun'),
(530,1,'Nahouri'),
(531,1,'Namentenga'),
(532,1,'Nayala'),
(533,1,'Noumbiel'),
(534,1,'Oubritenga'),
(535,1,'Oudalan'),
(536,1,'Passore'),
(537,1,'Poni'),
(538,1,'Sanguie'),
(539,1,'Sanmatenga'),
(540,1,'Seno'),
(541,1,'Sissili'),
(542,1,'Soum'),
(543,1,'Sourou'),
(544,1,'Tapoa'),
(545,1,'Tuy'),
(546,1,'Yagha'),
(547,1,'Yatenga'),
(548,1,'Ziro'),
(549,1,'Zondoma'),
(550,1,'Zoundweogo'),
(551,1,'Bubanza'),
(552,1,'Bujumbura'),
(553,1,'Bururi'),
(554,1,'Cankuzo'),
(555,1,'Cibitoke'),
(556,1,'Gitega'),
(557,1,'Karuzi'),
(558,1,'Kayanza'),
(559,1,'Kirundo'),
(560,1,'Makamba'),
(561,1,'Muramvya'),
(562,1,'Muyinga'),
(563,1,'Mwaro'),
(564,1,'Ngozi'),
(565,1,'Rutana'),
(566,1,'Ruyigi'),
(567,1,'Phnom Penh'),
(568,1,'Preah Seihanu (Kompong Som or Sihanoukville)'),
(569,1,'Pailin'),
(570,1,'Keb'),
(571,1,'Banteay Meanchey'),
(572,1,'Battambang'),
(573,1,'Kampong Cham'),
(574,1,'Kampong Chhnang'),
(575,1,'Kampong Speu'),
(576,1,'Kampong Som'),
(577,1,'Kampong Thom'),
(578,1,'Kampot'),
(579,1,'Kandal'),
(580,1,'Kaoh Kong'),
(581,1,'Kratie'),
(582,1,'Mondul Kiri'),
(583,1,'Oddar Meancheay'),
(584,1,'Pursat'),
(585,1,'Preah Vihear'),
(586,1,'Prey Veng'),
(587,1,'Ratanak Kiri'),
(588,1,'Siemreap'),
(589,1,'Stung Treng'),
(590,1,'Svay Rieng'),
(591,1,'Takeo'),
(592,1,'Adamawa (Adamaoua)'),
(593,1,'Centre'),
(594,1,'East (Est)'),
(595,1,'Extreme North (Extreme-Nord)'),
(596,1,'Littoral'),
(597,1,'North (Nord)'),
(598,1,'Northwest (Nord-Ouest)'),
(599,1,'West (Ouest)'),
(600,1,'South (Sud)'),
(601,1,'Southwest (Sud-Ouest).'),
(602,1,'Alberta'),
(603,1,'British Columbia'),
(604,1,'Manitoba'),
(605,1,'New Brunswick'),
(606,1,'Newfoundland and Labrador'),
(607,1,'Northwest Territories'),
(608,1,'Nova Scotia'),
(609,1,'Nunavut'),
(610,1,'Ontario'),
(611,1,'Prince Edward Island'),
(612,1,'Qu&eacute;bec'),
(613,1,'Saskatchewan'),
(614,1,'Yukon Territory'),
(615,1,'Boa Vista'),
(616,1,'Brava'),
(617,1,'Calheta de Sao Miguel'),
(618,1,'Maio'),
(619,1,'Mosteiros'),
(620,1,'Paul'),
(621,1,'Porto Novo'),
(622,1,'Praia'),
(623,1,'Ribeira Grande'),
(624,1,'Sal'),
(625,1,'Santa Catarina'),
(626,1,'Santa Cruz'),
(627,1,'Sao Domingos'),
(628,1,'Sao Filipe'),
(629,1,'Sao Nicolau'),
(630,1,'Sao Vicente'),
(631,1,'Tarrafal'),
(632,1,'Creek'),
(633,1,'Eastern'),
(634,1,'Midland'),
(635,1,'South Town'),
(636,1,'Spot Bay'),
(637,1,'Stake Bay'),
(638,1,'West End'),
(639,1,'Western'),
(640,1,'Bamingui-Bangoran'),
(641,1,'Basse-Kotto'),
(642,1,'Haute-Kotto'),
(643,1,'Haut-Mbomou'),
(644,1,'Kemo'),
(645,1,'Lobaye'),
(646,1,'Mambere-KadeÔ'),
(647,1,'Mbomou'),
(648,1,'Nana-Mambere'),
(649,1,'Ombella-M\'Poko'),
(650,1,'Ouaka'),
(651,1,'Ouham'),
(652,1,'Ouham-Pende'),
(653,1,'Vakaga'),
(654,1,'Nana-Grebizi'),
(655,1,'Sangha-Mbaere'),
(656,1,'Bangui'),
(657,1,'Batha'),
(658,1,'Biltine'),
(659,1,'Borkou-Ennedi-Tibesti'),
(660,1,'Chari-Baguirmi'),
(661,1,'Guera'),
(662,1,'Kanem'),
(663,1,'Lac'),
(664,1,'Logone Occidental'),
(665,1,'Logone Oriental'),
(666,1,'Mayo-Kebbi'),
(667,1,'Moyen-Chari'),
(668,1,'Ouaddai'),
(669,1,'Salamat'),
(670,1,'Tandjile'),
(671,1,'Aisen del General Carlos Ibanez'),
(672,1,'Antofagasta'),
(673,1,'Araucania'),
(674,1,'Atacama'),
(675,1,'Bio-Bio'),
(676,1,'Coquimbo'),
(677,1,'Libertador General Bernardo O\'Hi'),
(678,1,'Los Lagos'),
(679,1,'Magallanes y de la Antartica Chi'),
(680,1,'Maule'),
(681,1,'Region Metropolitana'),
(682,1,'Tarapaca'),
(683,1,'Valparaiso'),
(684,1,'Anhui'),
(685,1,'Beijing'),
(686,1,'Chongqing'),
(687,1,'Fujian'),
(688,1,'Gansu'),
(689,1,'Guangdong'),
(690,1,'Guangxi'),
(691,1,'Guizhou'),
(692,1,'Hainan'),
(693,1,'Hebei'),
(694,1,'Heilongjiang'),
(695,1,'Henan'),
(696,1,'Hong Kong'),
(697,1,'Hubei'),
(698,1,'Hunan'),
(699,1,'Inner Mongolia'),
(700,1,'Jiangsu'),
(701,1,'Jiangxi'),
(702,1,'Jilin'),
(703,1,'Liaoning'),
(704,1,'Macau'),
(705,1,'Ningxia'),
(706,1,'Shaanxi'),
(707,1,'Shandong'),
(708,1,'Shanghai'),
(709,1,'Shanxi'),
(710,1,'Sichuan'),
(711,1,'Tianjin'),
(712,1,'Xinjiang'),
(713,1,'Yunnan'),
(714,1,'Zhejiang'),
(715,1,'Direction Island'),
(716,1,'Home Island'),
(717,1,'Horsburgh Island'),
(718,1,'South Island'),
(719,1,'West Island'),
(720,1,'Amazonas'),
(721,1,'Antioquia'),
(722,1,'Arauca'),
(723,1,'Atlantico'),
(724,1,'Bogota D.C.'),
(725,1,'Bolivar'),
(726,1,'Boyaca'),
(727,1,'Caldas'),
(728,1,'Caqueta'),
(729,1,'Casanare'),
(730,1,'Cauca'),
(731,1,'Cesar'),
(732,1,'Choco'),
(733,1,'Cordoba'),
(734,1,'Cundinamarca'),
(735,1,'Guainia'),
(736,1,'Guajira'),
(737,1,'Guaviare'),
(738,1,'Huila'),
(739,1,'Magdalena'),
(740,1,'Meta'),
(741,1,'Narino'),
(742,1,'Norte de Santander'),
(743,1,'Putumayo'),
(744,1,'Quindio'),
(745,1,'Risaralda'),
(746,1,'San Andres y Providencia'),
(747,1,'Santander'),
(748,1,'Sucre'),
(749,1,'Tolima'),
(750,1,'Valle del Cauca'),
(751,1,'Vaupes'),
(752,1,'Vichada'),
(753,1,'Grande Comore'),
(754,1,'Anjouan'),
(755,1,'Moheli'),
(756,1,'Bouenza'),
(757,1,'Brazzaville'),
(758,1,'Cuvette'),
(759,1,'Cuvette-Ouest'),
(760,1,'Kouilou'),
(761,1,'Lekoumou'),
(762,1,'Likouala'),
(763,1,'Niari'),
(764,1,'Plateaux'),
(765,1,'Pool'),
(766,1,'Sangha'),
(767,1,'Pukapuka'),
(768,1,'Rakahanga'),
(769,1,'Manihiki'),
(770,1,'Penrhyn'),
(771,1,'Nassau Island'),
(772,1,'Surwarrow'),
(773,1,'Palmerston'),
(774,1,'Aitutaki'),
(775,1,'Manuae'),
(776,1,'Takutea'),
(777,1,'Mitiaro'),
(778,1,'Atiu'),
(779,1,'Mauke'),
(780,1,'Rarotonga'),
(781,1,'Mangaia'),
(782,1,'Alajuela'),
(783,1,'Cartago'),
(784,1,'Guanacaste'),
(785,1,'Heredia'),
(786,1,'Limon'),
(787,1,'Puntarenas'),
(788,1,'San Jose'),
(789,1,'Abengourou'),
(790,1,'Abidjan'),
(791,1,'Aboisso'),
(792,1,'Adiake'),
(793,1,'Adzope'),
(794,1,'Agboville'),
(795,1,'Agnibilekrou'),
(796,1,'Alepe'),
(797,1,'Bocanda'),
(798,1,'Bangolo'),
(799,1,'Beoumi'),
(800,1,'Biankouma'),
(801,1,'Bondoukou'),
(802,1,'Bongouanou'),
(803,1,'Bouafle'),
(804,1,'Bouake'),
(805,1,'Bouna'),
(806,1,'Boundiali'),
(807,1,'Dabakala'),
(808,1,'Dabou'),
(809,1,'Daloa'),
(810,1,'Danane'),
(811,1,'Daoukro'),
(812,1,'Dimbokro'),
(813,1,'Divo'),
(814,1,'Duekoue'),
(815,1,'Ferkessedougou'),
(816,1,'Gagnoa'),
(817,1,'Grand-Bassam'),
(818,1,'Grand-Lahou'),
(819,1,'Guiglo'),
(820,1,'Issia'),
(821,1,'Jacqueville'),
(822,1,'Katiola'),
(823,1,'Korhogo'),
(824,1,'Lakota'),
(825,1,'Man'),
(826,1,'Mankono'),
(827,1,'Mbahiakro'),
(828,1,'Odienne'),
(829,1,'Oume'),
(830,1,'Sakassou'),
(831,1,'San-Pedro'),
(832,1,'Sassandra'),
(833,1,'Seguela'),
(834,1,'Sinfra'),
(835,1,'Soubre'),
(836,1,'Tabou'),
(837,1,'Tanda'),
(838,1,'Tiebissou'),
(839,1,'Tingrela'),
(840,1,'Tiassale'),
(841,1,'Touba'),
(842,1,'Toulepleu'),
(843,1,'Toumodi'),
(844,1,'Vavoua'),
(845,1,'Yamoussoukro'),
(846,1,'Zuenoula'),
(847,1,'Bjelovar-Bilogora'),
(848,1,'City of Zagreb'),
(849,1,'Dubrovnik-Neretva'),
(850,1,'Istra'),
(851,1,'Karlovac'),
(852,1,'Koprivnica-Krizevci'),
(853,1,'Krapina-Zagorje'),
(854,1,'Lika-Senj'),
(855,1,'Medimurje'),
(856,1,'Osijek-Baranja'),
(857,1,'Pozega-Slavonia'),
(858,1,'Primorje-Gorski Kotar'),
(859,1,'Sibenik'),
(860,1,'Sisak-Moslavina'),
(861,1,'Slavonski Brod-Posavina'),
(862,1,'Split-Dalmatia'),
(863,1,'Varazdin'),
(864,1,'Virovitica-Podravina'),
(865,1,'Vukovar-Srijem'),
(866,1,'Zadar-Knin'),
(867,1,'Zagreb'),
(868,1,'Camaguey'),
(869,1,'Ciego de Avila'),
(870,1,'Cienfuegos'),
(871,1,'Ciudad de La Habana'),
(872,1,'Granma'),
(873,1,'Guantanamo'),
(874,1,'Holguin'),
(875,1,'Isla de la Juventud'),
(876,1,'La Habana'),
(877,1,'Las Tunas'),
(878,1,'Matanzas'),
(879,1,'Pinar del Rio'),
(880,1,'Sancti Spiritus'),
(881,1,'Santiago de Cuba'),
(882,1,'Villa Clara'),
(883,1,'Famagusta'),
(884,1,'Kyrenia'),
(885,1,'Larnaca'),
(886,1,'Limassol'),
(887,1,'Nicosia'),
(888,1,'Paphos'),
(889,1,'Ustecky'),
(890,1,'Jihocesky'),
(891,1,'Jihomoravsky'),
(892,1,'Karlovarsky'),
(893,1,'Kralovehradecky'),
(894,1,'Liberecky'),
(895,1,'Moravskoslezsky'),
(896,1,'Olomoucky'),
(897,1,'Pardubicky'),
(898,1,'Plzensky'),
(899,1,'Praha'),
(900,1,'Stredocesky'),
(901,1,'Vysocina'),
(902,1,'Zlinsky'),
(903,1,'Arhus'),
(904,1,'Bornholm'),
(905,1,'Copenhagen'),
(906,1,'Faroe Islands'),
(907,1,'Frederiksborg'),
(908,1,'Fyn'),
(909,1,'Kobenhavn'),
(910,1,'Nordjylland'),
(911,1,'Ribe'),
(912,1,'Ringkobing'),
(913,1,'Roskilde'),
(914,1,'Sonderjylland'),
(915,1,'Storstrom'),
(916,1,'Vejle'),
(917,1,'Vestj&aelig;lland'),
(918,1,'Viborg'),
(919,1,'\'Ali Sabih'),
(920,1,'Dikhil'),
(921,1,'Djibouti'),
(922,1,'Obock'),
(923,1,'Tadjoura'),
(924,1,'Saint Andrew Parish'),
(925,1,'Saint David Parish'),
(926,1,'Saint George Parish'),
(927,1,'Saint John Parish'),
(928,1,'Saint Joseph Parish'),
(929,1,'Saint Luke Parish'),
(930,1,'Saint Mark Parish'),
(931,1,'Saint Patrick Parish'),
(932,1,'Saint Paul Parish'),
(933,1,'Saint Peter Parish'),
(934,1,'Distrito Nacional'),
(935,1,'Azua'),
(936,1,'Baoruco'),
(937,1,'Barahona'),
(938,1,'Dajabon'),
(939,1,'Duarte'),
(940,1,'Elias Pina'),
(941,1,'El Seybo'),
(942,1,'Espaillat'),
(943,1,'Hato Mayor'),
(944,1,'Independencia'),
(945,1,'La Altagracia'),
(946,1,'La Romana'),
(947,1,'La Vega'),
(948,1,'Maria Trinidad Sanchez'),
(949,1,'Monsenor Nouel'),
(950,1,'Monte Cristi'),
(951,1,'Monte Plata'),
(952,1,'Pedernales'),
(953,1,'Peravia (Bani)'),
(954,1,'Puerto Plata'),
(955,1,'Salcedo'),
(956,1,'Samana'),
(957,1,'Sanchez Ramirez'),
(958,1,'San Cristobal'),
(959,1,'San Jose de Ocoa'),
(960,1,'San Juan'),
(961,1,'San Pedro de Macoris'),
(962,1,'Santiago'),
(963,1,'Santiago Rodriguez'),
(964,1,'Santo Domingo'),
(965,1,'Valverde'),
(966,1,'Aileu'),
(967,1,'Ainaro'),
(968,1,'Baucau'),
(969,1,'Bobonaro'),
(970,1,'Cova Lima'),
(971,1,'Dili'),
(972,1,'Ermera'),
(973,1,'Lautem'),
(974,1,'Liquica'),
(975,1,'Manatuto'),
(976,1,'Manufahi'),
(977,1,'Oecussi'),
(978,1,'Viqueque'),
(979,1,'Azuay'),
(980,1,'Bolivar'),
(981,1,'Ca&ntilde;ar'),
(982,1,'Carchi'),
(983,1,'Chimborazo'),
(984,1,'Cotopaxi'),
(985,1,'El Oro'),
(986,1,'Esmeraldas'),
(987,1,'Gal&aacute;pagos'),
(988,1,'Guayas'),
(989,1,'Imbabura'),
(990,1,'Loja'),
(991,1,'Los Rios'),
(992,1,'Manab&iacute;'),
(993,1,'Morona Santiago'),
(994,1,'Napo'),
(995,1,'Orellana'),
(996,1,'Pastaza'),
(997,1,'Pichincha'),
(998,1,'Sucumb&iacute;os'),
(999,1,'Tungurahua'),
(1000,1,'Zamora Chinchipe'),
(1001,1,'Ad Daqahliyah'),
(1002,1,'Al Bahr al Ahmar'),
(1003,1,'Al Buhayrah'),
(1004,1,'Al Fayyum'),
(1005,1,'Al Gharbiyah'),
(1006,1,'Al Iskandariyah'),
(1007,1,'Al Isma\'iliyah'),
(1008,1,'Al Jizah'),
(1009,1,'Al Minufiyah'),
(1010,1,'Al Minya'),
(1011,1,'Al Qahirah'),
(1012,1,'Al Qalyubiyah'),
(1013,1,'Al Wadi al Jadid'),
(1014,1,'Ash Sharqiyah'),
(1015,1,'As Suways'),
(1016,1,'Aswan'),
(1017,1,'Asyut'),
(1018,1,'Bani Suwayf'),
(1019,1,'Bur Sa\'id'),
(1020,1,'Dumyat'),
(1021,1,'Janub Sina\''),
(1022,1,'Kafr ash Shaykh'),
(1023,1,'Matruh'),
(1024,1,'Qina'),
(1025,1,'Shamal Sina\''),
(1026,1,'Suhaj'),
(1027,1,'Ahuachapan'),
(1028,1,'Cabanas'),
(1029,1,'Chalatenango'),
(1030,1,'Cuscatlan'),
(1031,1,'La Libertad'),
(1032,1,'La Paz'),
(1033,1,'La Union'),
(1034,1,'Morazan'),
(1035,1,'San Miguel'),
(1036,1,'San Salvador'),
(1037,1,'San Vicente'),
(1038,1,'Santa Ana'),
(1039,1,'Sonsonate'),
(1040,1,'Usulutan'),
(1041,1,'Provincia Annobon'),
(1042,1,'Provincia Bioko Norte'),
(1043,1,'Provincia Bioko Sur'),
(1044,1,'Provincia Centro Sur'),
(1045,1,'Provincia Kie-Ntem'),
(1046,1,'Provincia Litoral'),
(1047,1,'Provincia Wele-Nzas'),
(1048,1,'Central (Maekel)'),
(1049,1,'Anseba (Keren)'),
(1050,1,'Southern Red Sea (Debub-Keih-Bahri)'),
(1051,1,'Northern Red Sea (Semien-Keih-Bahri)'),
(1052,1,'Southern (Debub)'),
(1053,1,'Gash-Barka (Barentu)'),
(1054,1,'Harjumaa (Tallinn)'),
(1055,1,'Hiiumaa (Kardla)'),
(1056,1,'Ida-Virumaa (Johvi)'),
(1057,1,'Jarvamaa (Paide)'),
(1058,1,'Jogevamaa (Jogeva)'),
(1059,1,'Laane-Virumaa (Rakvere)'),
(1060,1,'Laanemaa (Haapsalu)'),
(1061,1,'Parnumaa (Parnu)'),
(1062,1,'Polvamaa (Polva)'),
(1063,1,'Raplamaa (Rapla)'),
(1064,1,'Saaremaa (Kuessaare)'),
(1065,1,'Tartumaa (Tartu)'),
(1066,1,'Valgamaa (Valga)'),
(1067,1,'Viljandimaa (Viljandi)'),
(1068,1,'Vorumaa (Voru)'),
(1069,1,'Afar'),
(1070,1,'Amhara'),
(1071,1,'Benishangul-Gumaz'),
(1072,1,'Gambela'),
(1073,1,'Hariai'),
(1074,1,'Oromia'),
(1075,1,'Somali'),
(1076,1,'Southern Nations - Nationalities and Peoples Region'),
(1077,1,'Tigray'),
(1078,1,'Addis Ababa'),
(1079,1,'Dire Dawa'),
(1080,1,'Central Division'),
(1081,1,'Northern Division'),
(1082,1,'Eastern Division'),
(1083,1,'Western Division'),
(1084,1,'Rotuma'),
(1085,1,'Ahvenanmaan Laani'),
(1086,1,'Etela-Suomen Laani'),
(1087,1,'Ita-Suomen Laani'),
(1088,1,'Lansi-Suomen Laani'),
(1089,1,'Lapin Lanani'),
(1090,1,'Oulun Laani'),
(1091,1,'Alsace'),
(1092,1,'Aquitaine'),
(1093,1,'Auvergne'),
(1094,1,'Brittany'),
(1095,1,'Burgundy'),
(1096,1,'Center Loire Valley'),
(1097,1,'Champagne'),
(1098,1,'Corse'),
(1099,1,'France Comte'),
(1100,1,'Languedoc Roussillon'),
(1101,1,'Limousin'),
(1102,1,'Lorraine'),
(1103,1,'Midi Pyrenees'),
(1104,1,'Nord Pas de Calais'),
(1105,1,'Normandy'),
(1106,1,'Paris / Ill de France'),
(1107,1,'Picardie'),
(1108,1,'Poitou Charente'),
(1109,1,'Provence'),
(1110,1,'Rhone Alps'),
(1111,1,'Riviera'),
(1112,1,'Western Loire Valley'),
(1113,1,'Etranger'),
(1114,1,'Ain'),
(1115,1,'Aisne'),
(1116,1,'Allier'),
(1117,1,'Alpes de Haute Provence'),
(1118,1,'Hautes-Alpes'),
(1119,1,'Alpes Maritimes'),
(1120,1,'Ard&egrave;che'),
(1121,1,'Ardennes'),
(1122,1,'Ari&egrave;ge'),
(1123,1,'Aube'),
(1124,1,'Aude'),
(1125,1,'Aveyron'),
(1126,1,'Bouches du Rh&ocirc;ne'),
(1127,1,'Calvados'),
(1128,1,'Cantal'),
(1129,1,'Charente'),
(1130,1,'Charente Maritime'),
(1131,1,'Cher'),
(1132,1,'Corr&egrave;ze'),
(1133,1,'Corse du Sud'),
(1134,1,'Haute Corse'),
(1135,1,'C&ocirc;te d&#039;or'),
(1136,1,'C&ocirc;tes d&#039;Armor'),
(1137,1,'Creuse'),
(1138,1,'Dordogne'),
(1139,1,'Doubs'),
(1140,1,'Dr&ocirc;me'),
(1141,1,'Eure'),
(1142,1,'Eure et Loir'),
(1143,1,'Finist&egrave;re'),
(1144,1,'Gard'),
(1145,1,'Haute Garonne'),
(1146,1,'Gers'),
(1147,1,'Gironde'),
(1148,1,'H&eacute;rault'),
(1149,1,'Ille et Vilaine'),
(1150,1,'Indre'),
(1151,1,'Indre et Loire'),
(1152,1,'Is&eacute;re'),
(1153,1,'Jura'),
(1154,1,'Landes'),
(1155,1,'Loir et Cher'),
(1156,1,'Loire'),
(1157,1,'Haute Loire'),
(1158,1,'Loire Atlantique'),
(1159,1,'Loiret'),
(1160,1,'Lot'),
(1161,1,'Lot et Garonne'),
(1162,1,'Loz&egrave;re'),
(1163,1,'Maine et Loire'),
(1164,1,'Manche'),
(1165,1,'Marne'),
(1166,1,'Haute Marne'),
(1167,1,'Mayenne'),
(1168,1,'Meurthe et Moselle'),
(1169,1,'Meuse'),
(1170,1,'Morbihan'),
(1171,1,'Moselle'),
(1172,1,'Ni&egrave;vre'),
(1173,1,'Nord'),
(1174,1,'Oise'),
(1175,1,'Orne'),
(1176,1,'Pas de Calais'),
(1177,1,'Puy de D&ocirc;me'),
(1178,1,'Pyr&eacute;n&eacute;es Atlantiques'),
(1179,1,'Hautes Pyr&eacute;n&eacute;es'),
(1180,1,'Pyr&eacute;n&eacute;es Orientales'),
(1181,1,'Bas Rhin'),
(1182,1,'Haut Rhin'),
(1183,1,'Rh&ocirc;ne'),
(1184,1,'Haute Sa&ocirc;ne'),
(1185,1,'Sa&ocirc;ne et Loire'),
(1186,1,'Sarthe'),
(1187,1,'Savoie'),
(1188,1,'Haute Savoie'),
(1189,1,'Paris'),
(1190,1,'Seine Maritime'),
(1191,1,'Seine et Marne'),
(1192,1,'Yvelines'),
(1193,1,'Deux S&egrave;vres'),
(1194,1,'Somme'),
(1195,1,'Tarn'),
(1196,1,'Tarn et Garonne'),
(1197,1,'Var'),
(1198,1,'Vaucluse'),
(1199,1,'Vend&eacute;e'),
(1200,1,'Vienne'),
(1201,1,'Haute Vienne'),
(1202,1,'Vosges'),
(1203,1,'Yonne'),
(1204,1,'Territoire de Belfort'),
(1205,1,'Essonne'),
(1206,1,'Hauts de Seine'),
(1207,1,'Seine St-Denis'),
(1208,1,'Val de Marne'),
(1209,1,'Val d\'Oise'),
(1210,1,'Archipel des Marquises'),
(1211,1,'Archipel des Tuamotu'),
(1212,1,'Archipel des Tubuai'),
(1213,1,'Iles du Vent'),
(1214,1,'Iles Sous-le-Vent'),
(1215,1,'Iles Crozet'),
(1216,1,'Iles Kerguelen'),
(1217,1,'Ile Amsterdam'),
(1218,1,'Ile Saint-Paul'),
(1219,1,'Adelie Land'),
(1220,1,'Estuaire'),
(1221,1,'Haut-Ogooue'),
(1222,1,'Moyen-Ogooue'),
(1223,1,'Ngounie'),
(1224,1,'Nyanga'),
(1225,1,'Ogooue-Ivindo'),
(1226,1,'Ogooue-Lolo'),
(1227,1,'Ogooue-Maritime'),
(1228,1,'Woleu-Ntem'),
(1229,1,'Banjul'),
(1230,1,'Basse'),
(1231,1,'Brikama'),
(1232,1,'Janjangbure'),
(1233,1,'Kanifeng'),
(1234,1,'Kerewan'),
(1235,1,'Kuntaur'),
(1236,1,'Mansakonko'),
(1237,1,'Lower River'),
(1238,1,'Central River'),
(1239,1,'North Bank'),
(1240,1,'Upper River'),
(1241,1,'Western'),
(1242,1,'Abkhazia'),
(1243,1,'Ajaria'),
(1244,1,'Tbilisi'),
(1245,1,'Guria'),
(1246,1,'Imereti'),
(1247,1,'Kakheti'),
(1248,1,'Kvemo Kartli'),
(1249,1,'Mtskheta-Mtianeti'),
(1250,1,'Racha Lechkhumi and Kvemo Svanet'),
(1251,1,'Samegrelo-Zemo Svaneti'),
(1252,1,'Samtskhe-Javakheti'),
(1253,1,'Shida Kartli'),
(1254,1,'Baden-W&uuml;rttemberg'),
(1255,1,'Bayern'),
(1256,1,'Berlin'),
(1257,1,'Brandenburg'),
(1258,1,'Bremen'),
(1259,1,'Hamburg'),
(1260,1,'Hessen'),
(1261,1,'Mecklenburg-Vorpommern'),
(1262,1,'Niedersachsen'),
(1263,1,'Nordrhein-Westfalen'),
(1264,1,'Rheinland-Pfalz'),
(1265,1,'Saarland'),
(1266,1,'Sachsen'),
(1267,1,'Sachsen-Anhalt'),
(1268,1,'Schleswig-Holstein'),
(1269,1,'Th&uuml;ringen'),
(1270,1,'Ashanti Region'),
(1271,1,'Brong-Ahafo Region'),
(1272,1,'Central Region'),
(1273,1,'Eastern Region'),
(1274,1,'Greater Accra Region'),
(1275,1,'Northern Region'),
(1276,1,'Upper East Region'),
(1277,1,'Upper West Region'),
(1278,1,'Volta Region'),
(1279,1,'Western Region'),
(1280,1,'Attica'),
(1281,1,'Central Greece'),
(1282,1,'Central Macedonia'),
(1283,1,'Crete'),
(1284,1,'East Macedonia and Thrace'),
(1285,1,'Epirus'),
(1286,1,'Ionian Islands'),
(1287,1,'North Aegean'),
(1288,1,'Peloponnesos'),
(1289,1,'South Aegean'),
(1290,1,'Thessaly'),
(1291,1,'West Greece'),
(1292,1,'West Macedonia'),
(1293,1,'Avannaa'),
(1294,1,'Tunu'),
(1295,1,'Kitaa'),
(1296,1,'Saint Andrew'),
(1297,1,'Saint David'),
(1298,1,'Saint George'),
(1299,1,'Saint John'),
(1300,1,'Saint Mark'),
(1301,1,'Saint Patrick'),
(1302,1,'Carriacou'),
(1303,1,'Petit Martinique'),
(1304,1,'Alta Verapaz'),
(1305,1,'Baja Verapaz'),
(1306,1,'Chimaltenango'),
(1307,1,'Chiquimula'),
(1308,1,'El Peten'),
(1309,1,'El Progreso'),
(1310,1,'El Quiche'),
(1311,1,'Escuintla'),
(1312,1,'Guatemala'),
(1313,1,'Huehuetenango'),
(1314,1,'Izabal'),
(1315,1,'Jalapa'),
(1316,1,'Jutiapa'),
(1317,1,'Quetzaltenango'),
(1318,1,'Retalhuleu'),
(1319,1,'Sacatepequez'),
(1320,1,'San Marcos'),
(1321,1,'Santa Rosa'),
(1322,1,'Solola'),
(1323,1,'Suchitepequez'),
(1324,1,'Totonicapan'),
(1325,1,'Zacapa'),
(1326,1,'Conakry'),
(1327,1,'Beyla'),
(1328,1,'Boffa'),
(1329,1,'Boke'),
(1330,1,'Coyah'),
(1331,1,'Dabola'),
(1332,1,'Dalaba'),
(1333,1,'Dinguiraye'),
(1334,1,'Dubreka'),
(1335,1,'Faranah'),
(1336,1,'Forecariah'),
(1337,1,'Fria'),
(1338,1,'Gaoual'),
(1339,1,'Gueckedou'),
(1340,1,'Kankan'),
(1341,1,'Kerouane'),
(1342,1,'Kindia'),
(1343,1,'Kissidougou'),
(1344,1,'Koubia'),
(1345,1,'Koundara'),
(1346,1,'Kouroussa'),
(1347,1,'Labe'),
(1348,1,'Lelouma'),
(1349,1,'Lola'),
(1350,1,'Macenta'),
(1351,1,'Mali'),
(1352,1,'Mamou'),
(1353,1,'Mandiana'),
(1354,1,'Nzerekore'),
(1355,1,'Pita'),
(1356,1,'Siguiri'),
(1357,1,'Telimele'),
(1358,1,'Tougue'),
(1359,1,'Yomou'),
(1360,1,'Bafata Region'),
(1361,1,'Biombo Region'),
(1362,1,'Bissau Region'),
(1363,1,'Bolama Region'),
(1364,1,'Cacheu Region'),
(1365,1,'Gabu Region'),
(1366,1,'Oio Region'),
(1367,1,'Quinara Region'),
(1368,1,'Tombali Region'),
(1369,1,'Barima-Waini'),
(1370,1,'Cuyuni-Mazaruni'),
(1371,1,'Demerara-Mahaica'),
(1372,1,'East Berbice-Corentyne'),
(1373,1,'Essequibo Islands-West Demerara'),
(1374,1,'Mahaica-Berbice'),
(1375,1,'Pomeroon-Supenaam'),
(1376,1,'Potaro-Siparuni'),
(1377,1,'Upper Demerara-Berbice'),
(1378,1,'Upper Takutu-Upper Essequibo'),
(1379,1,'Artibonite'),
(1380,1,'Centre'),
(1381,1,'Grand\'Anse'),
(1382,1,'Nord'),
(1383,1,'Nord-Est'),
(1384,1,'Nord-Ouest'),
(1385,1,'Ouest'),
(1386,1,'Sud'),
(1387,1,'Sud-Est'),
(1388,1,'Flat Island'),
(1389,1,'McDonald Island'),
(1390,1,'Shag Island'),
(1391,1,'Heard Island'),
(1392,1,'Atlantida'),
(1393,1,'Choluteca'),
(1394,1,'Colon'),
(1395,1,'Comayagua'),
(1396,1,'Copan'),
(1397,1,'Cortes'),
(1398,1,'El Paraiso'),
(1399,1,'Francisco Morazan'),
(1400,1,'Gracias a Dios'),
(1401,1,'Intibuca'),
(1402,1,'Islas de la Bahia (Bay Islands)'),
(1403,1,'La Paz'),
(1404,1,'Lempira'),
(1405,1,'Ocotepeque'),
(1406,1,'Olancho'),
(1407,1,'Santa Barbara'),
(1408,1,'Valle'),
(1409,1,'Yoro'),
(1410,1,'Central and Western Hong Kong Island'),
(1411,1,'Eastern Hong Kong Island'),
(1412,1,'Southern Hong Kong Island'),
(1413,1,'Wan Chai Hong Kong Island'),
(1414,1,'Kowloon City Kowloon'),
(1415,1,'Kwun Tong Kowloon'),
(1416,1,'Sham Shui Po Kowloon'),
(1417,1,'Wong Tai Sin Kowloon'),
(1418,1,'Yau Tsim Mong Kowloon'),
(1419,1,'Islands New Territories'),
(1420,1,'Kwai Tsing New Territories'),
(1421,1,'North New Territories'),
(1422,1,'Sai Kung New Territories'),
(1423,1,'Sha Tin New Territories'),
(1424,1,'Tai Po New Territories'),
(1425,1,'Tsuen Wan New Territories'),
(1426,1,'Tuen Mun New Territories'),
(1427,1,'Yuen Long New Territories'),
(1428,1,'Bacs-Kiskun'),
(1429,1,'Baranya'),
(1430,1,'Bekes'),
(1431,1,'Bekescsaba'),
(1432,1,'Borsod-Abauj-Zemplen'),
(1433,1,'Budapest'),
(1434,1,'Csongrad'),
(1435,1,'Debrecen'),
(1436,1,'Dunaujvaros'),
(1437,1,'Eger'),
(1438,1,'Fejer'),
(1439,1,'Gyor'),
(1440,1,'Gyor-Moson-Sopron'),
(1441,1,'Hajdu-Bihar'),
(1442,1,'Heves'),
(1443,1,'Hodmezovasarhely'),
(1444,1,'Jasz-Nagykun-Szolnok'),
(1445,1,'Kaposvar'),
(1446,1,'Kecskemet'),
(1447,1,'Komarom-Esztergom'),
(1448,1,'Miskolc'),
(1449,1,'Nagykanizsa'),
(1450,1,'Nograd'),
(1451,1,'Nyiregyhaza'),
(1452,1,'Pecs'),
(1453,1,'Pest'),
(1454,1,'Somogy'),
(1455,1,'Sopron'),
(1456,1,'Szabolcs-Szatmar-Bereg'),
(1457,1,'Szeged'),
(1458,1,'Szekesfehervar'),
(1459,1,'Szolnok'),
(1460,1,'Szombathely'),
(1461,1,'Tatabanya'),
(1462,1,'Tolna'),
(1463,1,'Vas'),
(1464,1,'Veszprem'),
(1465,1,'Zala'),
(1466,1,'Zalaegerszeg'),
(1467,1,'Austurland'),
(1468,1,'Hofuoborgarsvaeoi'),
(1469,1,'Norourland eystra'),
(1470,1,'Norourland vestra'),
(1471,1,'Suourland'),
(1472,1,'Suournes'),
(1473,1,'Vestfiroir'),
(1474,1,'Vesturland'),
(1475,1,'Andaman and Nicobar Islands'),
(1476,1,'Andhra Pradesh'),
(1477,1,'Arunachal Pradesh'),
(1478,1,'Assam'),
(1479,1,'Bihar'),
(1480,1,'Chandigarh'),
(1481,1,'Dadra and Nagar Haveli'),
(1482,1,'Daman and Diu'),
(1483,1,'Delhi'),
(1484,1,'Goa'),
(1485,1,'Gujarat'),
(1486,1,'Haryana'),
(1487,1,'Himachal Pradesh'),
(1488,1,'Jammu and Kashmir'),
(1489,1,'Karnataka'),
(1490,1,'Kerala'),
(1491,1,'Lakshadweep Islands'),
(1492,1,'Madhya Pradesh'),
(1493,1,'Maharashtra'),
(1494,1,'Manipur'),
(1495,1,'Meghalaya'),
(1496,1,'Mizoram'),
(1497,1,'Nagaland'),
(1498,1,'Orissa'),
(1499,1,'Pondicherry'),
(1500,1,'Punjab'),
(1501,1,'Rajasthan'),
(1502,1,'Sikkim'),
(1503,1,'Tamil Nadu'),
(1504,1,'Tripura'),
(1505,1,'Uttar Pradesh'),
(1506,1,'West Bengal'),
(1507,1,'Aceh'),
(1508,1,'Bali'),
(1509,1,'Banten'),
(1510,1,'Bengkulu'),
(1511,1,'BoDeTaBek'),
(1512,1,'Gorontalo'),
(1513,1,'Jakarta Raya'),
(1514,1,'Jambi'),
(1515,1,'Jawa Barat'),
(1516,1,'Jawa Tengah'),
(1517,1,'Jawa Timur'),
(1518,1,'Kalimantan Barat'),
(1519,1,'Kalimantan Selatan'),
(1520,1,'Kalimantan Tengah'),
(1521,1,'Kalimantan Timur'),
(1522,1,'Kepulauan Bangka Belitung'),
(1523,1,'Lampung'),
(1524,1,'Maluku'),
(1525,1,'Maluku Utara'),
(1526,1,'Nusa Tenggara Barat'),
(1527,1,'Nusa Tenggara Timur'),
(1528,1,'Papua'),
(1529,1,'Riau'),
(1530,1,'Sulawesi Selatan'),
(1531,1,'Sulawesi Tengah'),
(1532,1,'Sulawesi Tenggara'),
(1533,1,'Sulawesi Utara'),
(1534,1,'Sumatera Barat'),
(1535,1,'Sumatera Selatan'),
(1536,1,'Sumatera Utara'),
(1537,1,'Yogyakarta'),
(1538,1,'Tehran'),
(1539,1,'Qom'),
(1540,1,'Markazi'),
(1541,1,'Qazvin'),
(1542,1,'Gilan'),
(1543,1,'Ardabil'),
(1544,1,'Zanjan'),
(1545,1,'East Azarbaijan'),
(1546,1,'West Azarbaijan'),
(1547,1,'Kurdistan'),
(1548,1,'Hamadan'),
(1549,1,'Kermanshah'),
(1550,1,'Ilam'),
(1551,1,'Lorestan'),
(1552,1,'Khuzestan'),
(1553,1,'Chahar Mahaal and Bakhtiari'),
(1554,1,'Kohkiluyeh and Buyer Ahmad'),
(1555,1,'Bushehr'),
(1556,1,'Fars'),
(1557,1,'Hormozgan'),
(1558,1,'Sistan and Baluchistan'),
(1559,1,'Kerman'),
(1560,1,'Yazd'),
(1561,1,'Esfahan'),
(1562,1,'Semnan'),
(1563,1,'Mazandaran'),
(1564,1,'Golestan'),
(1565,1,'North Khorasan'),
(1566,1,'Razavi Khorasan'),
(1567,1,'South Khorasan'),
(1568,1,'Baghdad'),
(1569,1,'Salah ad Din'),
(1570,1,'Diyala'),
(1571,1,'Wasit'),
(1572,1,'Maysan'),
(1573,1,'Al Basrah'),
(1574,1,'Dhi Qar'),
(1575,1,'Al Muthanna'),
(1576,1,'Al Qadisyah'),
(1577,1,'Babil'),
(1578,1,'Al Karbala'),
(1579,1,'An Najaf'),
(1580,1,'Al Anbar'),
(1581,1,'Ninawa'),
(1582,1,'Dahuk'),
(1583,1,'Arbil'),
(1584,1,'At Ta\'mim'),
(1585,1,'As Sulaymaniyah'),
(1586,1,'Carlow'),
(1587,1,'Cavan'),
(1588,1,'Clare'),
(1589,1,'Cork'),
(1590,1,'Donegal'),
(1591,1,'Dublin'),
(1592,1,'Galway'),
(1593,1,'Kerry'),
(1594,1,'Kildare'),
(1595,1,'Kilkenny'),
(1596,1,'Laois'),
(1597,1,'Leitrim'),
(1598,1,'Limerick'),
(1599,1,'Longford'),
(1600,1,'Louth'),
(1601,1,'Mayo'),
(1602,1,'Meath'),
(1603,1,'Monaghan'),
(1604,1,'Offaly'),
(1605,1,'Roscommon'),
(1606,1,'Sligo'),
(1607,1,'Tipperary'),
(1608,1,'Waterford'),
(1609,1,'Westmeath'),
(1610,1,'Wexford'),
(1611,1,'Wicklow'),
(1612,1,'Be\'er Sheva'),
(1613,1,'Bika\'at Hayarden'),
(1614,1,'Eilat and Arava'),
(1615,1,'Galil'),
(1616,1,'Haifa'),
(1617,1,'Jehuda Mountains'),
(1618,1,'Jerusalem'),
(1619,1,'Negev'),
(1620,1,'Semaria'),
(1621,1,'Sharon'),
(1622,1,'Tel Aviv (Gosh Dan)'),
(3860,1,'Caltanissetta'),
(3842,1,'Agrigento'),
(3843,1,'Alessandria'),
(3844,1,'Ancona'),
(3845,1,'Aosta'),
(3846,1,'Arezzo'),
(3847,1,'Ascoli Piceno'),
(3848,1,'Asti'),
(3849,1,'Avellino'),
(3850,1,'Bari'),
(3851,1,'Belluno'),
(3852,1,'Benevento'),
(3853,1,'Bergamo'),
(3854,1,'Biella'),
(3855,1,'Bologna'),
(3856,1,'Bolzano'),
(3857,1,'Brescia'),
(3858,1,'Brindisi'),
(3859,1,'Cagliari'),
(1643,1,'Clarendon Parish'),
(1644,1,'Hanover Parish'),
(1645,1,'Kingston Parish'),
(1646,1,'Manchester Parish'),
(1647,1,'Portland Parish'),
(1648,1,'Saint Andrew Parish'),
(1649,1,'Saint Ann Parish'),
(1650,1,'Saint Catherine Parish'),
(1651,1,'Saint Elizabeth Parish'),
(1652,1,'Saint James Parish'),
(1653,1,'Saint Mary Parish'),
(1654,1,'Saint Thomas Parish'),
(1655,1,'Trelawny Parish'),
(1656,1,'Westmoreland Parish'),
(1657,1,'Aichi'),
(1658,1,'Akita'),
(1659,1,'Aomori'),
(1660,1,'Chiba'),
(1661,1,'Ehime'),
(1662,1,'Fukui'),
(1663,1,'Fukuoka'),
(1664,1,'Fukushima'),
(1665,1,'Gifu'),
(1666,1,'Gumma'),
(1667,1,'Hiroshima'),
(1668,1,'Hokkaido'),
(1669,1,'Hyogo'),
(1670,1,'Ibaraki'),
(1671,1,'Ishikawa'),
(1672,1,'Iwate'),
(1673,1,'Kagawa'),
(1674,1,'Kagoshima'),
(1675,1,'Kanagawa'),
(1676,1,'Kochi'),
(1677,1,'Kumamoto'),
(1678,1,'Kyoto'),
(1679,1,'Mie'),
(1680,1,'Miyagi'),
(1681,1,'Miyazaki'),
(1682,1,'Nagano'),
(1683,1,'Nagasaki'),
(1684,1,'Nara'),
(1685,1,'Niigata'),
(1686,1,'Oita'),
(1687,1,'Okayama'),
(1688,1,'Okinawa'),
(1689,1,'Osaka'),
(1690,1,'Saga'),
(1691,1,'Saitama'),
(1692,1,'Shiga'),
(1693,1,'Shimane'),
(1694,1,'Shizuoka'),
(1695,1,'Tochigi'),
(1696,1,'Tokushima'),
(1697,1,'Tokyo'),
(1698,1,'Tottori'),
(1699,1,'Toyama'),
(1700,1,'Wakayama'),
(1701,1,'Yamagata'),
(1702,1,'Yamaguchi'),
(1703,1,'Yamanashi'),
(1704,1,'\'Amman'),
(1705,1,'Ajlun'),
(1706,1,'Al \'Aqabah'),
(1707,1,'Al Balqa\''),
(1708,1,'Al Karak'),
(1709,1,'Al Mafraq'),
(1710,1,'At Tafilah'),
(1711,1,'Az Zarqa\''),
(1712,1,'Irbid'),
(1713,1,'Jarash'),
(1714,1,'Ma\'an'),
(1715,1,'Madaba'),
(1716,1,'Almaty'),
(1717,1,'Almaty City'),
(1718,1,'Aqmola'),
(1719,1,'Aqtobe'),
(1720,1,'Astana City'),
(1721,1,'Atyrau'),
(1722,1,'Batys Qazaqstan'),
(1723,1,'Bayqongyr City'),
(1724,1,'Mangghystau'),
(1725,1,'Ongtustik Qazaqstan'),
(1726,1,'Pavlodar'),
(1727,1,'Qaraghandy'),
(1728,1,'Qostanay'),
(1729,1,'Qyzylorda'),
(1730,1,'Shyghys Qazaqstan'),
(1731,1,'Soltustik Qazaqstan'),
(1732,1,'Zhambyl'),
(1733,1,'Central'),
(1734,1,'Coast'),
(1735,1,'Eastern'),
(1736,1,'Nairobi Area'),
(1737,1,'North Eastern'),
(1738,1,'Nyanza'),
(1739,1,'Rift Valley'),
(1740,1,'Western'),
(1741,1,'Abaiang'),
(1742,1,'Abemama'),
(1743,1,'Aranuka'),
(1744,1,'Arorae'),
(1745,1,'Banaba'),
(1746,1,'Beru'),
(1747,1,'Butaritari'),
(1748,1,'Kanton'),
(1749,1,'Kiritimati'),
(1750,1,'Kuria'),
(1751,1,'Maiana'),
(1752,1,'Makin'),
(1753,1,'Marakei'),
(1754,1,'Nikunau'),
(1755,1,'Nonouti'),
(1756,1,'Onotoa'),
(1757,1,'Tabiteuea'),
(1758,1,'Tabuaeran'),
(1759,1,'Tamana'),
(1760,1,'Tarawa'),
(1761,1,'Teraina'),
(1762,1,'Chagang-do'),
(1763,1,'Hamgyong-bukto'),
(1764,1,'Hamgyong-namdo'),
(1765,1,'Hwanghae-bukto'),
(1766,1,'Hwanghae-namdo'),
(1767,1,'Kangwon-do'),
(1768,1,'P\'yongan-bukto'),
(1769,1,'P\'yongan-namdo'),
(1770,1,'Ryanggang-do (Yanggang-do)'),
(1771,1,'Rason Directly Governed City'),
(1772,1,'P\'yongyang Special City'),
(1773,1,'Ch\'ungch\'ong-bukto'),
(1774,1,'Ch\'ungch\'ong-namdo'),
(1775,1,'Cheju-do'),
(1776,1,'Cholla-bukto'),
(1777,1,'Cholla-namdo'),
(1778,1,'Inch\'on-gwangyoksi'),
(1779,1,'Kangwon-do'),
(1780,1,'Kwangju-gwangyoksi'),
(1781,1,'Kyonggi-do'),
(1782,1,'Kyongsang-bukto'),
(1783,1,'Kyongsang-namdo'),
(1784,1,'Pusan-gwangyoksi'),
(1785,1,'Soul-t\'ukpyolsi'),
(1786,1,'Taegu-gwangyoksi'),
(1787,1,'Taejon-gwangyoksi'),
(1788,1,'Al \'Asimah'),
(1789,1,'Al Ahmadi'),
(1790,1,'Al Farwaniyah'),
(1791,1,'Al Jahra\''),
(1792,1,'Hawalli'),
(1793,1,'Bishkek'),
(1794,1,'Batken'),
(1795,1,'Chu'),
(1796,1,'Jalal-Abad'),
(1797,1,'Naryn'),
(1798,1,'Osh'),
(1799,1,'Talas'),
(1800,1,'Ysyk-Kol'),
(1801,1,'Vientiane'),
(1802,1,'Attapu'),
(1803,1,'Bokeo'),
(1804,1,'Bolikhamxai'),
(1805,1,'Champasak'),
(1806,1,'Houaphan'),
(1807,1,'Khammouan'),
(1808,1,'Louang Namtha'),
(1809,1,'Louangphabang'),
(1810,1,'Oudomxai'),
(1811,1,'Phongsali'),
(1812,1,'Salavan'),
(1813,1,'Savannakhet'),
(1814,1,'Vientiane'),
(1815,1,'Xaignabouli'),
(1816,1,'Xekong'),
(1817,1,'Xiangkhoang'),
(1818,1,'Xaisomboun'),
(1819,1,'Aizkraukles Rajons'),
(1820,1,'Aluksnes Rajons'),
(1821,1,'Balvu Rajons'),
(1822,1,'Bauskas Rajons'),
(1823,1,'Cesu Rajons'),
(1824,1,'Daugavpils Rajons'),
(1825,1,'Dobeles Rajons'),
(1826,1,'Gulbenes Rajons'),
(1827,1,'Jekabpils Rajons'),
(1828,1,'Jelgavas Rajons'),
(1829,1,'Kraslavas Rajons'),
(1830,1,'Kuldigas Rajons'),
(1831,1,'Liepajas Rajons'),
(1832,1,'Limbazu Rajons'),
(1833,1,'Ludzas Rajons'),
(1834,1,'Madonas Rajons'),
(1835,1,'Ogres Rajons'),
(1836,1,'Preilu Rajons'),
(1837,1,'Rezeknes Rajons'),
(1838,1,'Rigas Rajons'),
(1839,1,'Saldus Rajons'),
(1840,1,'Talsu Rajons'),
(1841,1,'Tukuma Rajons'),
(1842,1,'Valkas Rajons'),
(1843,1,'Valmieras Rajons'),
(1844,1,'Ventspils Rajons'),
(1845,1,'Daugavpils'),
(1846,1,'Jelgava'),
(1847,1,'Jurmala'),
(1848,1,'Liepaja'),
(1849,1,'Rezekne'),
(1850,1,'Riga'),
(1851,1,'Ventspils'),
(1852,1,'Berea'),
(1853,1,'Butha-Buthe'),
(1854,1,'Leribe'),
(1855,1,'Mafeteng'),
(1856,1,'Maseru'),
(1857,1,'Mohale\'s Hoek'),
(1858,1,'Mokhotlong'),
(1859,1,'Qacha\'s Nek'),
(1860,1,'Quthing'),
(1861,1,'Thaba-Tseka'),
(1862,1,'Bomi'),
(1863,1,'Bong'),
(1864,1,'Grand Bassa'),
(1865,1,'Grand Cape Mount'),
(1866,1,'Grand Gedeh'),
(1867,1,'Grand Kru'),
(1868,1,'Lofa'),
(1869,1,'Margibi'),
(1870,1,'Maryland'),
(1871,1,'Montserrado'),
(1872,1,'Nimba'),
(1873,1,'River Cess'),
(1874,1,'Sinoe'),
(1875,1,'Ajdabiya'),
(1876,1,'Al \'Aziziyah'),
(1877,1,'Al Fatih'),
(1878,1,'Al Jabal al Akhdar'),
(1879,1,'Al Jufrah'),
(1880,1,'Al Khums'),
(1881,1,'Al Kufrah'),
(1882,1,'An Nuqat al Khams'),
(1883,1,'Ash Shati\''),
(1884,1,'Awbari'),
(1885,1,'Az Zawiyah'),
(1886,1,'Banghazi'),
(1887,1,'Darnah'),
(1888,1,'Ghadamis'),
(1889,1,'Gharyan'),
(1890,1,'Misratah'),
(1891,1,'Murzuq'),
(1892,1,'Sabha'),
(1893,1,'Sawfajjin'),
(1894,1,'Surt'),
(1895,1,'Tarabulus (Tripoli)'),
(1896,1,'Tarhunah'),
(1897,1,'Tubruq'),
(1898,1,'Yafran'),
(1899,1,'Zlitan'),
(1900,1,'Vaduz'),
(1901,1,'Schaan'),
(1902,1,'Balzers'),
(1903,1,'Triesen'),
(1904,1,'Eschen'),
(1905,1,'Mauren'),
(1906,1,'Triesenberg'),
(1907,1,'Ruggell'),
(1908,1,'Gamprin'),
(1909,1,'Schellenberg'),
(1910,1,'Planken'),
(1911,1,'Alytus'),
(1912,1,'Kaunas'),
(1913,1,'Klaipeda'),
(1914,1,'Marijampole'),
(1915,1,'Panevezys'),
(1916,1,'Siauliai'),
(1917,1,'Taurage'),
(1918,1,'Telsiai'),
(1919,1,'Utena'),
(1920,1,'Vilnius'),
(1921,1,'Diekirch'),
(1922,1,'Clervaux'),
(1923,1,'Redange'),
(1924,1,'Vianden'),
(1925,1,'Wiltz'),
(1926,1,'Grevenmacher'),
(1927,1,'Echternach'),
(1928,1,'Remich'),
(1929,1,'Luxembourg'),
(1930,1,'Capellen'),
(1931,1,'Esch-sur-Alzette'),
(1932,1,'Mersch'),
(1933,1,'Our Lady Fatima Parish'),
(1934,1,'St. Anthony Parish'),
(1935,1,'St. Lazarus Parish'),
(1936,1,'Cathedral Parish'),
(1937,1,'St. Lawrence Parish'),
(1938,1,'Antananarivo'),
(1939,1,'Antsiranana'),
(1940,1,'Fianarantsoa'),
(1941,1,'Mahajanga'),
(1942,1,'Toamasina'),
(1943,1,'Toliara'),
(1944,1,'Balaka'),
(1945,1,'Blantyre'),
(1946,1,'Chikwawa'),
(1947,1,'Chiradzulu'),
(1948,1,'Chitipa'),
(1949,1,'Dedza'),
(1950,1,'Dowa'),
(1951,1,'Karonga'),
(1952,1,'Kasungu'),
(1953,1,'Likoma'),
(1954,1,'Lilongwe'),
(1955,1,'Machinga'),
(1956,1,'Mangochi'),
(1957,1,'Mchinji'),
(1958,1,'Mulanje'),
(1959,1,'Mwanza'),
(1960,1,'Mzimba'),
(1961,1,'Ntcheu'),
(1962,1,'Nkhata Bay'),
(1963,1,'Nkhotakota'),
(1964,1,'Nsanje'),
(1965,1,'Ntchisi'),
(1966,1,'Phalombe'),
(1967,1,'Rumphi'),
(1968,1,'Salima'),
(1969,1,'Thyolo'),
(1970,1,'Zomba'),
(1971,1,'Johor'),
(1972,1,'Kedah'),
(1973,1,'Kelantan'),
(1974,1,'Labuan'),
(1975,1,'Melaka'),
(1976,1,'Negeri Sembilan'),
(1977,1,'Pahang'),
(1978,1,'Perak'),
(1979,1,'Perlis'),
(1980,1,'Pulau Pinang'),
(1981,1,'Sabah'),
(1982,1,'Sarawak'),
(1983,1,'Selangor'),
(1984,1,'Terengganu'),
(1985,1,'Wilayah Persekutuan'),
(1986,1,'Thiladhunmathi Uthuru'),
(1987,1,'Thiladhunmathi Dhekunu'),
(1988,1,'Miladhunmadulu Uthuru'),
(1989,1,'Miladhunmadulu Dhekunu'),
(1990,1,'Maalhosmadulu Uthuru'),
(1991,1,'Maalhosmadulu Dhekunu'),
(1992,1,'Faadhippolhu'),
(1993,1,'Male Atoll'),
(1994,1,'Ari Atoll Uthuru'),
(1995,1,'Ari Atoll Dheknu'),
(1996,1,'Felidhe Atoll'),
(1997,1,'Mulaku Atoll'),
(1998,1,'Nilandhe Atoll Uthuru'),
(1999,1,'Nilandhe Atoll Dhekunu'),
(2000,1,'Kolhumadulu'),
(2001,1,'Hadhdhunmathi'),
(2002,1,'Huvadhu Atoll Uthuru'),
(2003,1,'Huvadhu Atoll Dhekunu'),
(2004,1,'Fua Mulaku'),
(2005,1,'Addu'),
(2006,1,'Gao'),
(2007,1,'Kayes'),
(2008,1,'Kidal'),
(2009,1,'Koulikoro'),
(2010,1,'Mopti'),
(2011,1,'Segou'),
(2012,1,'Sikasso'),
(2013,1,'Tombouctou'),
(2014,1,'Bamako Capital District'),
(2015,1,'Attard'),
(2016,1,'Balzan'),
(2017,1,'Birgu'),
(2018,1,'Birkirkara'),
(2019,1,'Birzebbuga'),
(2020,1,'Bormla'),
(2021,1,'Dingli'),
(2022,1,'Fgura'),
(2023,1,'Floriana'),
(2024,1,'Gudja'),
(2025,1,'Gzira'),
(2026,1,'Gargur'),
(2027,1,'Gaxaq'),
(2028,1,'Hamrun'),
(2029,1,'Iklin'),
(2030,1,'Isla'),
(2031,1,'Kalkara'),
(2032,1,'Kirkop'),
(2033,1,'Lija'),
(2034,1,'Luqa'),
(2035,1,'Marsa'),
(2036,1,'Marsaskala'),
(2037,1,'Marsaxlokk'),
(2038,1,'Mdina'),
(2039,1,'Melliea'),
(2040,1,'Mgarr'),
(2041,1,'Mosta'),
(2042,1,'Mqabba'),
(2043,1,'Msida'),
(2044,1,'Mtarfa'),
(2045,1,'Naxxar'),
(2046,1,'Paola'),
(2047,1,'Pembroke'),
(2048,1,'Pieta'),
(2049,1,'Qormi'),
(2050,1,'Qrendi'),
(2051,1,'Rabat'),
(2052,1,'Safi'),
(2053,1,'San Giljan'),
(2054,1,'Santa Lucija'),
(2055,1,'San Pawl il-Bahar'),
(2056,1,'San Gwann'),
(2057,1,'Santa Venera'),
(2058,1,'Siggiewi'),
(2059,1,'Sliema'),
(2060,1,'Swieqi'),
(2061,1,'Ta Xbiex'),
(2062,1,'Tarxien'),
(2063,1,'Valletta'),
(2064,1,'Xgajra'),
(2065,1,'Zabbar'),
(2066,1,'Zebbug'),
(2067,1,'Zejtun'),
(2068,1,'Zurrieq'),
(2069,1,'Fontana'),
(2070,1,'Ghajnsielem'),
(2071,1,'Gharb'),
(2072,1,'Ghasri'),
(2073,1,'Kercem'),
(2074,1,'Munxar'),
(2075,1,'Nadur'),
(2076,1,'Qala'),
(2077,1,'Victoria'),
(2078,1,'San Lawrenz'),
(2079,1,'Sannat'),
(2080,1,'Xagra'),
(2081,1,'Xewkija'),
(2082,1,'Zebbug'),
(2083,1,'Ailinginae'),
(2084,1,'Ailinglaplap'),
(2085,1,'Ailuk'),
(2086,1,'Arno'),
(2087,1,'Aur'),
(2088,1,'Bikar'),
(2089,1,'Bikini'),
(2090,1,'Bokak'),
(2091,1,'Ebon'),
(2092,1,'Enewetak'),
(2093,1,'Erikub'),
(2094,1,'Jabat'),
(2095,1,'Jaluit'),
(2096,1,'Jemo'),
(2097,1,'Kili'),
(2098,1,'Kwajalein'),
(2099,1,'Lae'),
(2100,1,'Lib'),
(2101,1,'Likiep'),
(2102,1,'Majuro'),
(2103,1,'Maloelap'),
(2104,1,'Mejit'),
(2105,1,'Mili'),
(2106,1,'Namorik'),
(2107,1,'Namu'),
(2108,1,'Rongelap'),
(2109,1,'Rongrik'),
(2110,1,'Toke'),
(2111,1,'Ujae'),
(2112,1,'Ujelang'),
(2113,1,'Utirik'),
(2114,1,'Wotho'),
(2115,1,'Wotje'),
(2116,1,'Adrar'),
(2117,1,'Assaba'),
(2118,1,'Brakna'),
(2119,1,'Dakhlet Nouadhibou'),
(2120,1,'Gorgol'),
(2121,1,'Guidimaka'),
(2122,1,'Hodh Ech Chargui'),
(2123,1,'Hodh El Gharbi'),
(2124,1,'Inchiri'),
(2125,1,'Tagant'),
(2126,1,'Tiris Zemmour'),
(2127,1,'Trarza'),
(2128,1,'Nouakchott'),
(2129,1,'Beau Bassin-Rose Hill'),
(2130,1,'Curepipe'),
(2131,1,'Port Louis'),
(2132,1,'Quatre Bornes'),
(2133,1,'Vacoas-Phoenix'),
(2134,1,'Agalega Islands'),
(2135,1,'Cargados Carajos Shoals (Saint Brandon Islands)'),
(2136,1,'Rodrigues'),
(2137,1,'Black River'),
(2138,1,'Flacq'),
(2139,1,'Grand Port'),
(2140,1,'Moka'),
(2141,1,'Pamplemousses'),
(2142,1,'Plaines Wilhems'),
(2143,1,'Port Louis'),
(2144,1,'Riviere du Rempart'),
(2145,1,'Savanne'),
(2146,1,'Baja California Norte'),
(2147,1,'Baja California Sur'),
(2148,1,'Campeche'),
(2149,1,'Chiapas'),
(2150,1,'Chihuahua'),
(2151,1,'Coahuila de Zaragoza'),
(2152,1,'Colima'),
(2153,1,'Distrito Federal'),
(2154,1,'Durango'),
(2155,1,'Guanajuato'),
(2156,1,'Guerrero'),
(2157,1,'Hidalgo'),
(2158,1,'Jalisco'),
(2159,1,'Mexico'),
(2160,1,'Michoacan de Ocampo'),
(2161,1,'Morelos'),
(2162,1,'Nayarit'),
(2163,1,'Nuevo Leon'),
(2164,1,'Oaxaca'),
(2165,1,'Puebla'),
(2166,1,'Queretaro de Arteaga'),
(2167,1,'Quintana Roo'),
(2168,1,'San Luis Potosi'),
(2169,1,'Sinaloa'),
(2170,1,'Sonora'),
(2171,1,'Tabasco'),
(2172,1,'Tamaulipas'),
(2173,1,'Tlaxcala'),
(2174,1,'Veracruz-Llave'),
(2175,1,'Yucatan'),
(2176,1,'Zacatecas'),
(2177,1,'Chuuk'),
(2178,1,'Kosrae'),
(2179,1,'Pohnpei'),
(2180,1,'Yap'),
(2181,1,'Gagauzia'),
(2182,1,'Chisinau'),
(2183,1,'Balti'),
(2184,1,'Cahul'),
(2185,1,'Edinet'),
(2186,1,'Lapusna'),
(2187,1,'Orhei'),
(2188,1,'Soroca'),
(2189,1,'Tighina'),
(2190,1,'Ungheni'),
(2191,1,'St‚nga Nistrului'),
(2192,1,'Fontvieille'),
(2193,1,'La Condamine'),
(2194,1,'Monaco-Ville'),
(2195,1,'Monte-Carlo'),
(2196,1,'Ulanbaatar'),
(2197,1,'Orhon'),
(2198,1,'Darhan uul'),
(2199,1,'Hentiy'),
(2200,1,'Hovsgol'),
(2201,1,'Hovd'),
(2202,1,'Uvs'),
(2203,1,'Tov'),
(2204,1,'Selenge'),
(2205,1,'Suhbaatar'),
(2206,1,'Omnogovi'),
(2207,1,'Ovorhangay'),
(2208,1,'Dzavhan'),
(2209,1,'DundgovL'),
(2210,1,'Dornod'),
(2211,1,'Dornogov'),
(2212,1,'Govi-Sumber'),
(2213,1,'Govi-Altay'),
(2214,1,'Bulgan'),
(2215,1,'Bayanhongor'),
(2216,1,'Bayan-Olgiy'),
(2217,1,'Arhangay'),
(2218,1,'Saint Anthony'),
(2219,1,'Saint Georges'),
(2220,1,'Saint Peter'),
(2221,1,'Agadir'),
(2222,1,'Al Hoceima'),
(2223,1,'Azilal'),
(2224,1,'Beni Mellal'),
(2225,1,'Ben Slimane'),
(2226,1,'Boulemane'),
(2227,1,'Casablanca'),
(2228,1,'Chaouen'),
(2229,1,'El Jadida'),
(2230,1,'El Kelaa des Sraghna'),
(2231,1,'Er Rachidia'),
(2232,1,'Essaouira'),
(2233,1,'Fes'),
(2234,1,'Figuig'),
(2235,1,'Guelmim'),
(2236,1,'Ifrane'),
(2237,1,'Kenitra'),
(2238,1,'Khemisset'),
(2239,1,'Khenifra'),
(2240,1,'Khouribga'),
(2241,1,'Laayoune'),
(2242,1,'Larache'),
(2243,1,'Marrakech'),
(2244,1,'Meknes'),
(2245,1,'Nador'),
(2246,1,'Ouarzazate'),
(2247,1,'Oujda'),
(2248,1,'Rabat-Sale'),
(2249,1,'Safi'),
(2250,1,'Settat'),
(2251,1,'Sidi Kacem'),
(2252,1,'Tangier'),
(2253,1,'Tan-Tan'),
(2254,1,'Taounate'),
(2255,1,'Taroudannt'),
(2256,1,'Tata'),
(2257,1,'Taza'),
(2258,1,'Tetouan'),
(2259,1,'Tiznit'),
(2260,1,'Ad Dakhla'),
(2261,1,'Boujdour'),
(2262,1,'Es Smara'),
(2263,1,'Cabo Delgado'),
(2264,1,'Gaza'),
(2265,1,'Inhambane'),
(2266,1,'Manica'),
(2267,1,'Maputo (city)'),
(2268,1,'Maputo'),
(2269,1,'Nampula'),
(2270,1,'Niassa'),
(2271,1,'Sofala'),
(2272,1,'Tete'),
(2273,1,'Zambezia'),
(2274,1,'Ayeyarwady'),
(2275,1,'Bago'),
(2276,1,'Magway'),
(2277,1,'Mandalay'),
(2278,1,'Sagaing'),
(2279,1,'Tanintharyi'),
(2280,1,'Yangon'),
(2281,1,'Chin State'),
(2282,1,'Kachin State'),
(2283,1,'Kayah State'),
(2284,1,'Kayin State'),
(2285,1,'Mon State'),
(2286,1,'Rakhine State'),
(2287,1,'Shan State'),
(2288,1,'Caprivi'),
(2289,1,'Erongo'),
(2290,1,'Hardap'),
(2291,1,'Karas'),
(2292,1,'Kavango'),
(2293,1,'Khomas'),
(2294,1,'Kunene'),
(2295,1,'Ohangwena'),
(2296,1,'Omaheke'),
(2297,1,'Omusati'),
(2298,1,'Oshana'),
(2299,1,'Oshikoto'),
(2300,1,'Otjozondjupa'),
(2301,1,'Aiwo'),
(2302,1,'Anabar'),
(2303,1,'Anetan'),
(2304,1,'Anibare'),
(2305,1,'Baiti'),
(2306,1,'Boe'),
(2307,1,'Buada'),
(2308,1,'Denigomodu'),
(2309,1,'Ewa'),
(2310,1,'Ijuw'),
(2311,1,'Meneng'),
(2312,1,'Nibok'),
(2313,1,'Uaboe'),
(2314,1,'Yaren'),
(2315,1,'Bagmati'),
(2316,1,'Bheri'),
(2317,1,'Dhawalagiri'),
(2318,1,'Gandaki'),
(2319,1,'Janakpur'),
(2320,1,'Karnali'),
(2321,1,'Kosi'),
(2322,1,'Lumbini'),
(2323,1,'Mahakali'),
(2324,1,'Mechi'),
(2325,1,'Narayani'),
(2326,1,'Rapti'),
(2327,1,'Sagarmatha'),
(2328,1,'Seti'),
(2329,1,'Drenthe'),
(2330,1,'Flevoland'),
(2331,1,'Friesland'),
(2332,1,'Gelderland'),
(2333,1,'Groningen'),
(2334,1,'Limburg'),
(2335,1,'Noord Brabant'),
(2336,1,'Noord Holland'),
(2337,1,'Overijssel'),
(2338,1,'Utrecht'),
(2339,1,'Zeeland'),
(2340,1,'Zuid Holland'),
(2341,1,'Iles Loyaute'),
(2342,1,'Nord'),
(2343,1,'Sud'),
(2344,1,'Auckland'),
(2345,1,'Bay of Plenty'),
(2346,1,'Canterbury'),
(2347,1,'Coromandel'),
(2348,1,'Gisborne'),
(2349,1,'Fiordland'),
(2350,1,'Hawke\'s Bay'),
(2351,1,'Marlborough'),
(2352,1,'Manawatu-Wanganui'),
(2353,1,'Mt Cook-Mackenzie'),
(2354,1,'Nelson'),
(2355,1,'Northland'),
(2356,1,'Otago'),
(2357,1,'Southland'),
(2358,1,'Taranaki'),
(2359,1,'Wellington'),
(2360,1,'Waikato'),
(2361,1,'Wairprarapa'),
(2362,1,'West Coast'),
(2363,1,'Atlantico Norte'),
(2364,1,'Atlantico Sur'),
(2365,1,'Boaco'),
(2366,1,'Carazo'),
(2367,1,'Chinandega'),
(2368,1,'Chontales'),
(2369,1,'Esteli'),
(2370,1,'Granada'),
(2371,1,'Jinotega'),
(2372,1,'Leon'),
(2373,1,'Madriz'),
(2374,1,'Managua'),
(2375,1,'Masaya'),
(2376,1,'Matagalpa'),
(2377,1,'Nuevo Segovia'),
(2378,1,'Rio San Juan'),
(2379,1,'Rivas'),
(2380,1,'Agadez'),
(2381,1,'Diffa'),
(2382,1,'Dosso'),
(2383,1,'Maradi'),
(2384,1,'Niamey'),
(2385,1,'Tahoua'),
(2386,1,'Tillaberi'),
(2387,1,'Zinder'),
(2388,1,'Abia'),
(2389,1,'Abuja Federal Capital Territory'),
(2390,1,'Adamawa'),
(2391,1,'Akwa Ibom'),
(2392,1,'Anambra'),
(2393,1,'Bauchi'),
(2394,1,'Bayelsa'),
(2395,1,'Benue'),
(2396,1,'Borno'),
(2397,1,'Cross River'),
(2398,1,'Delta'),
(2399,1,'Ebonyi'),
(2400,1,'Edo'),
(2401,1,'Ekiti'),
(2402,1,'Enugu'),
(2403,1,'Gombe'),
(2404,1,'Imo'),
(2405,1,'Jigawa'),
(2406,1,'Kaduna'),
(2407,1,'Kano'),
(2408,1,'Katsina'),
(2409,1,'Kebbi'),
(2410,1,'Kogi'),
(2411,1,'Kwara'),
(2412,1,'Lagos'),
(2413,1,'Nassarawa'),
(2414,1,'Niger'),
(2415,1,'Ogun'),
(2416,1,'Ondo'),
(2417,1,'Osun'),
(2418,1,'Oyo'),
(2419,1,'Plateau'),
(2420,1,'Rivers'),
(2421,1,'Sokoto'),
(2422,1,'Taraba'),
(2423,1,'Yobe'),
(2424,1,'Zamfara'),
(2425,1,'Northern Islands'),
(2426,1,'Rota'),
(2427,1,'Saipan'),
(2428,1,'Tinian'),
(2429,1,'Akershus'),
(2430,1,'Aust-Agder'),
(2431,1,'Buskerud'),
(2432,1,'Finnmark'),
(2433,1,'Hedmark'),
(2434,1,'Hordaland'),
(2435,1,'More og Romdal'),
(2436,1,'Nord-Trondelag'),
(2437,1,'Nordland'),
(2438,1,'Ostfold'),
(2439,1,'Oppland'),
(2440,1,'Oslo'),
(2441,1,'Rogaland'),
(2442,1,'Sor-Trondelag'),
(2443,1,'Sogn og Fjordane'),
(2444,1,'Svalbard'),
(2445,1,'Telemark'),
(2446,1,'Troms'),
(2447,1,'Vest-Agder'),
(2448,1,'Vestfold'),
(2449,1,'Ad Dakhiliyah'),
(2450,1,'Al Batinah'),
(2451,1,'Al Wusta'),
(2452,1,'Ash Sharqiyah'),
(2453,1,'Az Zahirah'),
(2454,1,'Masqat'),
(2455,1,'Musandam'),
(2456,1,'Zufar'),
(2457,1,'Balochistan'),
(2458,1,'Federally Administered Tribal Areas'),
(2459,1,'Islamabad Capital Territory'),
(2460,1,'North-West Frontier'),
(2461,1,'Punjab'),
(2462,1,'Sindh'),
(2463,1,'Aimeliik'),
(2464,1,'Airai'),
(2465,1,'Angaur'),
(2466,1,'Hatohobei'),
(2467,1,'Kayangel'),
(2468,1,'Koror'),
(2469,1,'Melekeok'),
(2470,1,'Ngaraard'),
(2471,1,'Ngarchelong'),
(2472,1,'Ngardmau'),
(2473,1,'Ngatpang'),
(2474,1,'Ngchesar'),
(2475,1,'Ngeremlengui'),
(2476,1,'Ngiwal'),
(2477,1,'Peleliu'),
(2478,1,'Sonsorol'),
(2479,1,'Bocas del Toro'),
(2480,1,'Chiriqui'),
(2481,1,'Cocle'),
(2482,1,'Colon'),
(2483,1,'Darien'),
(2484,1,'Herrera'),
(2485,1,'Los Santos'),
(2486,1,'Panama'),
(2487,1,'San Blas'),
(2488,1,'Veraguas'),
(2489,1,'Bougainville'),
(2490,1,'Central'),
(2491,1,'Chimbu'),
(2492,1,'Eastern Highlands'),
(2493,1,'East New Britain'),
(2494,1,'East Sepik'),
(2495,1,'Enga'),
(2496,1,'Gulf'),
(2497,1,'Madang'),
(2498,1,'Manus'),
(2499,1,'Milne Bay'),
(2500,1,'Morobe'),
(2501,1,'National Capital'),
(2502,1,'New Ireland'),
(2503,1,'Northern'),
(2504,1,'Sandaun'),
(2505,1,'Southern Highlands'),
(2506,1,'Western'),
(2507,1,'Western Highlands'),
(2508,1,'West New Britain'),
(2509,1,'Alto Paraguay'),
(2510,1,'Alto Parana'),
(2511,1,'Amambay'),
(2512,1,'Asuncion'),
(2513,1,'Boqueron'),
(2514,1,'Caaguazu'),
(2515,1,'Caazapa'),
(2516,1,'Canindeyu'),
(2517,1,'Central'),
(2518,1,'Concepcion'),
(2519,1,'Cordillera'),
(2520,1,'Guaira'),
(2521,1,'Itapua'),
(2522,1,'Misiones'),
(2523,1,'Neembucu'),
(2524,1,'Paraguari'),
(2525,1,'Presidente Hayes'),
(2526,1,'San Pedro'),
(2527,1,'Amazonas'),
(2528,1,'Ancash'),
(2529,1,'Apurimac'),
(2530,1,'Arequipa'),
(2531,1,'Ayacucho'),
(2532,1,'Cajamarca'),
(2533,1,'Callao'),
(2534,1,'Cusco'),
(2535,1,'Huancavelica'),
(2536,1,'Huanuco'),
(2537,1,'Ica'),
(2538,1,'Junin'),
(2539,1,'La Libertad'),
(2540,1,'Lambayeque'),
(2541,1,'Lima'),
(2542,1,'Loreto'),
(2543,1,'Madre de Dios'),
(2544,1,'Moquegua'),
(2545,1,'Pasco'),
(2546,1,'Piura'),
(2547,1,'Puno'),
(2548,1,'San Martin'),
(2549,1,'Tacna'),
(2550,1,'Tumbes'),
(2551,1,'Ucayali'),
(2552,1,'Abra'),
(2553,1,'Agusan del Norte'),
(2554,1,'Agusan del Sur'),
(2555,1,'Aklan'),
(2556,1,'Albay'),
(2557,1,'Antique'),
(2558,1,'Apayao'),
(2559,1,'Aurora'),
(2560,1,'Basilan'),
(2561,1,'Bataan'),
(2562,1,'Batanes'),
(2563,1,'Batangas'),
(2564,1,'Biliran'),
(2565,1,'Benguet'),
(2566,1,'Bohol'),
(2567,1,'Bukidnon'),
(2568,1,'Bulacan'),
(2569,1,'Cagayan'),
(2570,1,'Camarines Norte'),
(2571,1,'Camarines Sur'),
(2572,1,'Camiguin'),
(2573,1,'Capiz'),
(2574,1,'Catanduanes'),
(2575,1,'Cavite'),
(2576,1,'Cebu'),
(2577,1,'Compostela'),
(2578,1,'Davao del Norte'),
(2579,1,'Davao del Sur'),
(2580,1,'Davao Oriental'),
(2581,1,'Eastern Samar'),
(2582,1,'Guimaras'),
(2583,1,'Ifugao'),
(2584,1,'Ilocos Norte'),
(2585,1,'Ilocos Sur'),
(2586,1,'Iloilo'),
(2587,1,'Isabela'),
(2588,1,'Kalinga'),
(2589,1,'Laguna'),
(2590,1,'Lanao del Norte'),
(2591,1,'Lanao del Sur'),
(2592,1,'La Union'),
(2593,1,'Leyte'),
(2594,1,'Maguindanao'),
(2595,1,'Marinduque'),
(2596,1,'Masbate'),
(2597,1,'Mindoro Occidental'),
(2598,1,'Mindoro Oriental'),
(2599,1,'Misamis Occidental'),
(2600,1,'Misamis Oriental'),
(2601,1,'Mountain'),
(2602,1,'Negros Occidental'),
(2603,1,'Negros Oriental'),
(2604,1,'North Cotabato'),
(2605,1,'Northern Samar'),
(2606,1,'Nueva Ecija'),
(2607,1,'Nueva Vizcaya'),
(2608,1,'Palawan'),
(2609,1,'Pampanga'),
(2610,1,'Pangasinan'),
(2611,1,'Quezon'),
(2612,1,'Quirino'),
(2613,1,'Rizal'),
(2614,1,'Romblon'),
(2615,1,'Samar'),
(2616,1,'Sarangani'),
(2617,1,'Siquijor'),
(2618,1,'Sorsogon'),
(2619,1,'South Cotabato'),
(2620,1,'Southern Leyte'),
(2621,1,'Sultan Kudarat'),
(2622,1,'Sulu'),
(2623,1,'Surigao del Norte'),
(2624,1,'Surigao del Sur'),
(2625,1,'Tarlac'),
(2626,1,'Tawi-Tawi'),
(2627,1,'Zambales'),
(2628,1,'Zamboanga del Norte'),
(2629,1,'Zamboanga del Sur'),
(2630,1,'Zamboanga Sibugay'),
(2631,1,'Dolnoslaskie'),
(2632,1,'Kujawsko-Pomorskie'),
(2633,1,'Lodzkie'),
(2634,1,'Lubelskie'),
(2635,1,'Lubuskie'),
(2636,1,'Malopolskie'),
(2637,1,'Mazowieckie'),
(2638,1,'Opolskie'),
(2639,1,'Podkarpackie'),
(2640,1,'Podlaskie'),
(2641,1,'Pomorskie'),
(2642,1,'Slaskie'),
(2643,1,'Swietokrzyskie'),
(2644,1,'Warminsko-Mazurskie'),
(2645,1,'Wielkopolskie'),
(2646,1,'Zachodniopomorskie'),
(2647,1,'Saint Pierre'),
(2648,1,'Miquelon'),
(2649,1,'A&ccedil;ores'),
(2650,1,'Aveiro'),
(2651,1,'Beja'),
(2652,1,'Braga'),
(2653,1,'Bragan&ccedil;a'),
(2654,1,'Castelo Branco'),
(2655,1,'Coimbra'),
(2656,1,'&Eacute;vora'),
(2657,1,'Faro'),
(2658,1,'Guarda'),
(2659,1,'Leiria'),
(2660,1,'Lisboa'),
(2661,1,'Madeira'),
(2662,1,'Portalegre'),
(2663,1,'Porto'),
(2664,1,'Santar&eacute;m'),
(2665,1,'Set&uacute;bal'),
(2666,1,'Viana do Castelo'),
(2667,1,'Vila Real'),
(2668,1,'Viseu'),
(2669,1,'Ad Dawhah'),
(2670,1,'Al Ghuwayriyah'),
(2671,1,'Al Jumayliyah'),
(2672,1,'Al Khawr'),
(2673,1,'Al Wakrah'),
(2674,1,'Ar Rayyan'),
(2675,1,'Jarayan al Batinah'),
(2676,1,'Madinat ash Shamal'),
(2677,1,'Umm Sa\'id'),
(2678,1,'Umm Salal'),
(2679,1,'Alba'),
(2680,1,'Arad'),
(2681,1,'Arges'),
(2682,1,'Bacau'),
(2683,1,'Bihor'),
(2684,1,'Bistrita-Nasaud'),
(2685,1,'Botosani'),
(2686,1,'Brasov'),
(2687,1,'Braila'),
(2688,1,'Bucuresti'),
(2689,1,'Buzau'),
(2690,1,'Caras-Severin'),
(2691,1,'Calarasi'),
(2692,1,'Cluj'),
(2693,1,'Constanta'),
(2694,1,'Covasna'),
(2695,1,'Dimbovita'),
(2696,1,'Dolj'),
(2697,1,'Galati'),
(2698,1,'Giurgiu'),
(2699,1,'Gorj'),
(2700,1,'Harghita'),
(2701,1,'Hunedoara'),
(2702,1,'Ialomita'),
(2703,1,'Iasi'),
(2704,1,'Ilfov'),
(2705,1,'Maramures'),
(2706,1,'Mehedinti'),
(2707,1,'Mures'),
(2708,1,'Neamt'),
(2709,1,'Olt'),
(2710,1,'Prahova'),
(2711,1,'Satu-Mare'),
(2712,1,'Salaj'),
(2713,1,'Sibiu'),
(2714,1,'Suceava'),
(2715,1,'Teleorman'),
(2716,1,'Timis'),
(2717,1,'Tulcea'),
(2718,1,'Vaslui'),
(2719,1,'Valcea'),
(2720,1,'Vrancea'),
(2721,1,'Abakan'),
(2722,1,'Aginskoye'),
(2723,1,'Anadyr'),
(2724,1,'Arkahangelsk'),
(2725,1,'Astrakhan'),
(2726,1,'Barnaul'),
(2727,1,'Belgorod'),
(2728,1,'Birobidzhan'),
(2729,1,'Blagoveshchensk'),
(2730,1,'Bryansk'),
(2731,1,'Cheboksary'),
(2732,1,'Chelyabinsk'),
(2733,1,'Cherkessk'),
(2734,1,'Chita'),
(2735,1,'Dudinka'),
(2736,1,'Elista'),
(2737,1,'Gomo-Altaysk'),
(2738,1,'Gorno-Altaysk'),
(2739,1,'Groznyy'),
(2740,1,'Irkutsk'),
(2741,1,'Ivanovo'),
(2742,1,'Izhevsk'),
(2743,1,'Kalinigrad'),
(2744,1,'Kaluga'),
(2745,1,'Kasnodar'),
(2746,1,'Kazan'),
(2747,1,'Kemerovo'),
(2748,1,'Khabarovsk'),
(2749,1,'Khanty-Mansiysk'),
(2750,1,'Kostroma'),
(2751,1,'Krasnodar'),
(2752,1,'Krasnoyarsk'),
(2753,1,'Kudymkar'),
(2754,1,'Kurgan'),
(2755,1,'Kursk'),
(2756,1,'Kyzyl'),
(2757,1,'Lipetsk'),
(2758,1,'Magadan'),
(2759,1,'Makhachkala'),
(2760,1,'Maykop'),
(2761,1,'Moscow'),
(2762,1,'Murmansk'),
(2763,1,'Nalchik'),
(2764,1,'Naryan Mar'),
(2765,1,'Nazran'),
(2766,1,'Nizhniy Novgorod'),
(2767,1,'Novgorod'),
(2768,1,'Novosibirsk'),
(2769,1,'Omsk'),
(2770,1,'Orel'),
(2771,1,'Orenburg'),
(2772,1,'Palana'),
(2773,1,'Penza'),
(2774,1,'Perm'),
(2775,1,'Petropavlovsk-Kamchatskiy'),
(2776,1,'Petrozavodsk'),
(2777,1,'Pskov'),
(2778,1,'Rostov-na-Donu'),
(2779,1,'Ryazan'),
(2780,1,'Salekhard'),
(2781,1,'Samara'),
(2782,1,'Saransk'),
(2783,1,'Saratov'),
(2784,1,'Smolensk'),
(2785,1,'St. Petersburg'),
(2786,1,'Stavropol'),
(2787,1,'Syktyvkar'),
(2788,1,'Tambov'),
(2789,1,'Tomsk'),
(2790,1,'Tula'),
(2791,1,'Tura'),
(2792,1,'Tver'),
(2793,1,'Tyumen'),
(2794,1,'Ufa'),
(2795,1,'Ul\'yanovsk'),
(2796,1,'Ulan-Ude'),
(2797,1,'Ust\'-Ordynskiy'),
(2798,1,'Vladikavkaz'),
(2799,1,'Vladimir'),
(2800,1,'Vladivostok'),
(2801,1,'Volgograd'),
(2802,1,'Vologda'),
(2803,1,'Voronezh'),
(2804,1,'Vyatka'),
(2805,1,'Yakutsk'),
(2806,1,'Yaroslavl'),
(2807,1,'Yekaterinburg'),
(2808,1,'Yoshkar-Ola'),
(2809,1,'Butare'),
(2810,1,'Byumba'),
(2811,1,'Cyangugu'),
(2812,1,'Gikongoro'),
(2813,1,'Gisenyi'),
(2814,1,'Gitarama'),
(2815,1,'Kibungo'),
(2816,1,'Kibuye'),
(2817,1,'Kigali Rurale'),
(2818,1,'Kigali-ville'),
(2819,1,'Ruhengeri'),
(2820,1,'Umutara'),
(2821,1,'Christ Church Nichola Town'),
(2822,1,'Saint Anne Sandy Point'),
(2823,1,'Saint George Basseterre'),
(2824,1,'Saint George Gingerland'),
(2825,1,'Saint James Windward'),
(2826,1,'Saint John Capesterre'),
(2827,1,'Saint John Figtree'),
(2828,1,'Saint Mary Cayon'),
(2829,1,'Saint Paul Capesterre'),
(2830,1,'Saint Paul Charlestown'),
(2831,1,'Saint Peter Basseterre'),
(2832,1,'Saint Thomas Lowland'),
(2833,1,'Saint Thomas Middle Island'),
(2834,1,'Trinity Palmetto Point'),
(2835,1,'Anse-la-Raye'),
(2836,1,'Castries'),
(2837,1,'Choiseul'),
(2838,1,'Dauphin'),
(2839,1,'Dennery'),
(2840,1,'Gros-Islet'),
(2841,1,'Laborie'),
(2842,1,'Micoud'),
(2843,1,'Praslin'),
(2844,1,'Soufriere'),
(2845,1,'Vieux-Fort'),
(2846,1,'Charlotte'),
(2847,1,'Grenadines'),
(2848,1,'Saint Andrew'),
(2849,1,'Saint David'),
(2850,1,'Saint George'),
(2851,1,'Saint Patrick'),
(2852,1,'A\'ana'),
(2853,1,'Aiga-i-le-Tai'),
(2854,1,'Atua'),
(2855,1,'Fa\'asaleleaga'),
(2856,1,'Gaga\'emauga'),
(2857,1,'Gagaifomauga'),
(2858,1,'Palauli'),
(2859,1,'Satupa\'itea'),
(2860,1,'Tuamasaga'),
(2861,1,'Va\'a-o-Fonoti'),
(2862,1,'Vaisigano'),
(2863,1,'Acquaviva'),
(2864,1,'Borgo Maggiore'),
(2865,1,'Chiesanuova'),
(2866,1,'Domagnano'),
(2867,1,'Faetano'),
(2868,1,'Fiorentino'),
(2869,1,'Montegiardino'),
(2870,1,'Citta di San Marino'),
(2871,1,'Serravalle'),
(2872,1,'Sao Tome'),
(2873,1,'Principe'),
(2874,1,'Al Bahah'),
(2875,1,'Al Hudud ash Shamaliyah'),
(2876,1,'Al Jawf'),
(2877,1,'Al Madinah'),
(2878,1,'Al Qasim'),
(2879,1,'Ar Riyad'),
(2880,1,'Ash Sharqiyah (Eastern)'),
(2881,1,'\'Asir'),
(2882,1,'Ha\'il'),
(2883,1,'Jizan'),
(2884,1,'Makkah'),
(2885,1,'Najran'),
(2886,1,'Tabuk'),
(2887,1,'Dakar'),
(2888,1,'Diourbel'),
(2889,1,'Fatick'),
(2890,1,'Kaolack'),
(2891,1,'Kolda'),
(2892,1,'Louga'),
(2893,1,'Matam'),
(2894,1,'Saint-Louis'),
(2895,1,'Tambacounda'),
(2896,1,'Thies'),
(2897,1,'Ziguinchor'),
(2898,1,'Anse aux Pins'),
(2899,1,'Anse Boileau'),
(2900,1,'Anse Etoile'),
(2901,1,'Anse Louis'),
(2902,1,'Anse Royale'),
(2903,1,'Baie Lazare'),
(2904,1,'Baie Sainte Anne'),
(2905,1,'Beau Vallon'),
(2906,1,'Bel Air'),
(2907,1,'Bel Ombre'),
(2908,1,'Cascade'),
(2909,1,'Glacis'),
(2910,1,'Grand\' Anse (on Mahe)'),
(2911,1,'Grand\' Anse (on Praslin)'),
(2912,1,'La Digue'),
(2913,1,'La Riviere Anglaise'),
(2914,1,'Mont Buxton'),
(2915,1,'Mont Fleuri'),
(2916,1,'Plaisance'),
(2917,1,'Pointe La Rue'),
(2918,1,'Port Glaud'),
(2919,1,'Saint Louis'),
(2920,1,'Takamaka'),
(2921,1,'Eastern'),
(2922,1,'Northern'),
(2923,1,'Southern'),
(2924,1,'Western'),
(2925,1,'Banskobystrický'),
(2926,1,'Bratislavský'),
(2927,1,'Košický'),
(2928,1,'Nitriansky'),
(2929,1,'Prešovský'),
(2930,1,'Trenčiansky'),
(2931,1,'Trnavský'),
(2932,1,'Žilinský'),
(2933,1,'Central'),
(2934,1,'Choiseul'),
(2935,1,'Guadalcanal'),
(2936,1,'Honiara'),
(2937,1,'Isabel'),
(2938,1,'Makira'),
(2939,1,'Malaita'),
(2940,1,'Rennell and Bellona'),
(2941,1,'Temotu'),
(2942,1,'Western'),
(2943,1,'Awdal'),
(2944,1,'Bakool'),
(2945,1,'Banaadir'),
(2946,1,'Bari'),
(2947,1,'Bay'),
(2948,1,'Galguduud'),
(2949,1,'Gedo'),
(2950,1,'Hiiraan'),
(2951,1,'Jubbada Dhexe'),
(2952,1,'Jubbada Hoose'),
(2953,1,'Mudug'),
(2954,1,'Nugaal'),
(2955,1,'Sanaag'),
(2956,1,'Shabeellaha Dhexe'),
(2957,1,'Shabeellaha Hoose'),
(2958,1,'Sool'),
(2959,1,'Togdheer'),
(2960,1,'Woqooyi Galbeed'),
(2961,1,'Eastern Cape'),
(2962,1,'Free State'),
(2963,1,'Gauteng'),
(2964,1,'KwaZulu-Natal'),
(2965,1,'Limpopo'),
(2966,1,'Mpumalanga'),
(2967,1,'North West'),
(2968,1,'Northern Cape'),
(2969,1,'Western Cape'),
(2970,1,'La Coru&ntilde;a'),
(2971,1,'&Aacute;lava'),
(2972,1,'Albacete'),
(2973,1,'Alicante'),
(2974,1,'Almeria'),
(2975,1,'Asturias'),
(2976,1,'&Aacute;vila'),
(2977,1,'Badajoz'),
(2978,1,'Baleares'),
(2979,1,'Barcelona'),
(2980,1,'Burgos'),
(2981,1,'C&aacute;ceres'),
(2982,1,'C&aacute;diz'),
(2983,1,'Cantabria'),
(2984,1,'Castell&oacute;n'),
(2985,1,'Ceuta'),
(2986,1,'Ciudad Real'),
(2987,1,'C&oacute;rdoba'),
(2988,1,'Cuenca'),
(2989,1,'Girona'),
(2990,1,'Granada'),
(2991,1,'Guadalajara'),
(2992,1,'Guip&uacute;zcoa'),
(2993,1,'Huelva'),
(2994,1,'Huesca'),
(2995,1,'Ja&eacute;n'),
(2996,1,'La Rioja'),
(2997,1,'Las Palmas'),
(2998,1,'Leon'),
(2999,1,'Lleida'),
(3000,1,'Lugo'),
(3001,1,'Madrid'),
(3002,1,'Malaga'),
(3003,1,'Melilla'),
(3004,1,'Murcia'),
(3005,1,'Navarra'),
(3006,1,'Ourense'),
(3007,1,'Palencia'),
(3008,1,'Pontevedra'),
(3009,1,'Salamanca'),
(3010,1,'Santa Cruz de Tenerife'),
(3011,1,'Segovia'),
(3012,1,'Sevilla'),
(3013,1,'Soria'),
(3014,1,'Tarragona'),
(3015,1,'Teruel'),
(3016,1,'Toledo'),
(3017,1,'Valencia'),
(3018,1,'Valladolid'),
(3019,1,'Vizcaya'),
(3020,1,'Zamora'),
(3021,1,'Zaragoza'),
(3022,1,'Central'),
(3023,1,'Eastern'),
(3024,1,'North Central'),
(3025,1,'Northern'),
(3026,1,'North Western'),
(3027,1,'Sabaragamuwa'),
(3028,1,'Southern'),
(3029,1,'Uva'),
(3030,1,'Western'),
(3031,1,'Ascension'),
(3032,1,'Saint Helena'),
(3033,1,'Tristan da Cunha'),
(3034,1,'A\'ali an Nil'),
(3035,1,'Al Bahr al Ahmar'),
(3036,1,'Al Buhayrat'),
(3037,1,'Al Jazirah'),
(3038,1,'Al Khartum'),
(3039,1,'Al Qadarif'),
(3040,1,'Al Wahdah'),
(3041,1,'An Nil al Abyad'),
(3042,1,'An Nil al Azraq'),
(3043,1,'Ash Shamaliyah'),
(3044,1,'Bahr al Jabal'),
(3045,1,'Gharb al Istiwa\'iyah'),
(3046,1,'Gharb Bahr al Ghazal'),
(3047,1,'Gharb Darfur'),
(3048,1,'Gharb Kurdufan'),
(3049,1,'Janub Darfur'),
(3050,1,'Janub Kurdufan'),
(3051,1,'Junqali'),
(3052,1,'Kassala'),
(3053,1,'Nahr an Nil'),
(3054,1,'Shamal Bahr al Ghazal'),
(3055,1,'Shamal Darfur'),
(3056,1,'Shamal Kurdufan'),
(3057,1,'Sharq al Istiwa\'iyah'),
(3058,1,'Sinnar'),
(3059,1,'Warab'),
(3060,1,'Brokopondo'),
(3061,1,'Commewijne'),
(3062,1,'Coronie'),
(3063,1,'Marowijne'),
(3064,1,'Nickerie'),
(3065,1,'Para'),
(3066,1,'Paramaribo'),
(3067,1,'Saramacca'),
(3068,1,'Sipaliwini'),
(3069,1,'Wanica'),
(3070,1,'Hhohho'),
(3071,1,'Lubombo'),
(3072,1,'Manzini'),
(3073,1,'Shishelweni'),
(3074,1,'Blekinge'),
(3075,1,'Dalama'),
(3076,1,'G&auml;vleborg'),
(3077,1,'Gotland'),
(3078,1,'Halland'),
(3079,1,'J&auml;mtland'),
(3080,1,'J&ouml;nk&ouml;ping'),
(3081,1,'Kalmar'),
(3082,1,'Kronoberg'),
(3083,1,'Norrbotten'),
(3084,1,'&Ouml;rebro'),
(3085,1,'&Ouml;sterg&ouml;tland'),
(3086,1,'Sk&aring;ne'),
(3087,1,'S&ouml;dermanland'),
(3088,1,'Stockholm'),
(3089,1,'Uppsala'),
(3090,1,'V&auml;rmland'),
(3091,1,'V&auml;sterbotten'),
(3092,1,'V&auml;sternorrland'),
(3093,1,'V&auml;stmanland'),
(3094,1,'V&auml;stra G&ouml;taland'),
(3095,1,'Aargau'),
(3096,1,'Appenzell Ausserrhoden'),
(3097,1,'Appenzell Innerrhoden'),
(3098,1,'Basel-Stadt'),
(3099,1,'Basel-Landschaft'),
(3100,1,'Bern'),
(3101,1,'Fribourg'),
(3102,1,'Gen&egrave;ve'),
(3103,1,'Glarus'),
(3104,1,'Graub&uuml;nden'),
(3105,1,'Jura'),
(3106,1,'Luzern'),
(3107,1,'Neuch&acirc;tel'),
(3108,1,'Nidwald'),
(3109,1,'Obwald'),
(3110,1,'St. Gallen'),
(3111,1,'Schaffhausen'),
(3112,1,'Schwyz'),
(3113,1,'Solothurn'),
(3114,1,'Thurgau'),
(3115,1,'Ticino'),
(3116,1,'Uri'),
(3117,1,'Valais'),
(3118,1,'Vaud'),
(3119,1,'Zug'),
(3120,1,'Z&uuml;rich'),
(3121,1,'Al Hasakah'),
(3122,1,'Al Ladhiqiyah'),
(3123,1,'Al Qunaytirah'),
(3124,1,'Ar Raqqah'),
(3125,1,'As Suwayda'),
(3126,1,'Dara'),
(3127,1,'Dayr az Zawr'),
(3128,1,'Dimashq'),
(3129,1,'Halab'),
(3130,1,'Hamah'),
(3131,1,'Hims'),
(3132,1,'Idlib'),
(3133,1,'Rif Dimashq'),
(3134,1,'Tartus'),
(3135,1,'Chang-hua'),
(3136,1,'Chia-i'),
(3137,1,'Hsin-chu'),
(3138,1,'Hua-lien'),
(3139,1,'I-lan'),
(3140,1,'Kao-hsiung county'),
(3141,1,'Kin-men'),
(3142,1,'Lien-chiang'),
(3143,1,'Miao-li'),
(3144,1,'Nan-t\'ou'),
(3145,1,'P\'eng-hu'),
(3146,1,'P\'ing-tung'),
(3147,1,'T\'ai-chung'),
(3148,1,'T\'ai-nan'),
(3149,1,'T\'ai-pei county'),
(3150,1,'T\'ai-tung'),
(3151,1,'T\'ao-yuan'),
(3152,1,'Yun-lin'),
(3153,1,'Chia-i city'),
(3154,1,'Chi-lung'),
(3155,1,'Hsin-chu'),
(3156,1,'T\'ai-chung'),
(3157,1,'T\'ai-nan'),
(3158,1,'Kao-hsiung city'),
(3159,1,'T\'ai-pei city'),
(3160,1,'Gorno-Badakhstan'),
(3161,1,'Khatlon'),
(3162,1,'Sughd'),
(3163,1,'Arusha'),
(3164,1,'Dar es Salaam'),
(3165,1,'Dodoma'),
(3166,1,'Iringa'),
(3167,1,'Kagera'),
(3168,1,'Kigoma'),
(3169,1,'Kilimanjaro'),
(3170,1,'Lindi'),
(3171,1,'Manyara'),
(3172,1,'Mara'),
(3173,1,'Mbeya'),
(3174,1,'Morogoro'),
(3175,1,'Mtwara'),
(3176,1,'Mwanza'),
(3177,1,'Pemba North'),
(3178,1,'Pemba South'),
(3179,1,'Pwani'),
(3180,1,'Rukwa'),
(3181,1,'Ruvuma'),
(3182,1,'Shinyanga'),
(3183,1,'Singida'),
(3184,1,'Tabora'),
(3185,1,'Tanga'),
(3186,1,'Zanzibar Central/South'),
(3187,1,'Zanzibar North'),
(3188,1,'Zanzibar Urban/West'),
(3189,1,'Amnat Charoen'),
(3190,1,'Ang Thong'),
(3191,1,'Ayutthaya'),
(3192,1,'Bangkok'),
(3193,1,'Buriram'),
(3194,1,'Chachoengsao'),
(3195,1,'Chai Nat'),
(3196,1,'Chaiyaphum'),
(3197,1,'Chanthaburi'),
(3198,1,'Chiang Mai'),
(3199,1,'Chiang Rai'),
(3200,1,'Chon Buri'),
(3201,1,'Chumphon'),
(3202,1,'Kalasin'),
(3203,1,'Kamphaeng Phet'),
(3204,1,'Kanchanaburi'),
(3205,1,'Khon Kaen'),
(3206,1,'Krabi'),
(3207,1,'Lampang'),
(3208,1,'Lamphun'),
(3209,1,'Loei'),
(3210,1,'Lop Buri'),
(3211,1,'Mae Hong Son'),
(3212,1,'Maha Sarakham'),
(3213,1,'Mukdahan'),
(3214,1,'Nakhon Nayok'),
(3215,1,'Nakhon Pathom'),
(3216,1,'Nakhon Phanom'),
(3217,1,'Nakhon Ratchasima'),
(3218,1,'Nakhon Sawan'),
(3219,1,'Nakhon Si Thammarat'),
(3220,1,'Nan'),
(3221,1,'Narathiwat'),
(3222,1,'Nong Bua Lamphu'),
(3223,1,'Nong Khai'),
(3224,1,'Nonthaburi'),
(3225,1,'Pathum Thani'),
(3226,1,'Pattani'),
(3227,1,'Phangnga'),
(3228,1,'Phatthalung'),
(3229,1,'Phayao'),
(3230,1,'Phetchabun'),
(3231,1,'Phetchaburi'),
(3232,1,'Phichit'),
(3233,1,'Phitsanulok'),
(3234,1,'Phrae'),
(3235,1,'Phuket'),
(3236,1,'Prachin Buri'),
(3237,1,'Prachuap Khiri Khan'),
(3238,1,'Ranong'),
(3239,1,'Ratchaburi'),
(3240,1,'Rayong'),
(3241,1,'Roi Et'),
(3242,1,'Sa Kaeo'),
(3243,1,'Sakon Nakhon'),
(3244,1,'Samut Prakan'),
(3245,1,'Samut Sakhon'),
(3246,1,'Samut Songkhram'),
(3247,1,'Sara Buri'),
(3248,1,'Satun'),
(3249,1,'Sing Buri'),
(3250,1,'Sisaket'),
(3251,1,'Songkhla'),
(3252,1,'Sukhothai'),
(3253,1,'Suphan Buri'),
(3254,1,'Surat Thani'),
(3255,1,'Surin'),
(3256,1,'Tak'),
(3257,1,'Trang'),
(3258,1,'Trat'),
(3259,1,'Ubon Ratchathani'),
(3260,1,'Udon Thani'),
(3261,1,'Uthai Thani'),
(3262,1,'Uttaradit'),
(3263,1,'Yala'),
(3264,1,'Yasothon'),
(3265,1,'Kara'),
(3266,1,'Plateaux'),
(3267,1,'Savanes'),
(3268,1,'Centrale'),
(3269,1,'Maritime'),
(3270,1,'Atafu'),
(3271,1,'Fakaofo'),
(3272,1,'Nukunonu'),
(3273,1,'Ha\'apai'),
(3274,1,'Tongatapu'),
(3275,1,'Vava\'u'),
(3276,1,'Couva/Tabaquite/Talparo'),
(3277,1,'Diego Martin'),
(3278,1,'Mayaro/Rio Claro'),
(3279,1,'Penal/Debe'),
(3280,1,'Princes Town'),
(3281,1,'Sangre Grande'),
(3282,1,'San Juan/Laventille'),
(3283,1,'Siparia'),
(3284,1,'Tunapuna/Piarco'),
(3285,1,'Port of Spain'),
(3286,1,'San Fernando'),
(3287,1,'Arima'),
(3288,1,'Point Fortin'),
(3289,1,'Chaguanas'),
(3290,1,'Tobago'),
(3291,1,'Ariana'),
(3292,1,'Beja'),
(3293,1,'Ben Arous'),
(3294,1,'Bizerte'),
(3295,1,'Gabes'),
(3296,1,'Gafsa'),
(3297,1,'Jendouba'),
(3298,1,'Kairouan'),
(3299,1,'Kasserine'),
(3300,1,'Kebili'),
(3301,1,'Kef'),
(3302,1,'Mahdia'),
(3303,1,'Manouba'),
(3304,1,'Medenine'),
(3305,1,'Monastir'),
(3306,1,'Nabeul'),
(3307,1,'Sfax'),
(3308,1,'Sidi'),
(3309,1,'Siliana'),
(3310,1,'Sousse'),
(3311,1,'Tataouine'),
(3312,1,'Tozeur'),
(3313,1,'Tunis'),
(3314,1,'Zaghouan'),
(3315,1,'Adana'),
(3316,1,'Adiyaman'),
(3317,1,'Afyonkarahisar'),
(3318,1,'Agri'),
(3319,1,'Aksaray'),
(3320,1,'Amasya'),
(3321,1,'Ankara'),
(3322,1,'Antalya'),
(3323,1,'Ardahan'),
(3324,1,'Artvin'),
(3325,1,'Aydin'),
(3326,1,'Balikesir'),
(3327,1,'Bartin'),
(3328,1,'Batman'),
(3329,1,'Bayburt'),
(3330,1,'Bilecik'),
(3331,1,'Bingol'),
(3332,1,'Bitlis'),
(3333,1,'Bolu'),
(3334,1,'Burdur'),
(3335,1,'Bursa'),
(3336,1,'Canakkale'),
(3337,1,'Cankiri'),
(3338,1,'Corum'),
(3339,1,'Denizli'),
(3340,1,'Diyarbakir'),
(3341,1,'Duzce'),
(3342,1,'Edirne'),
(3343,1,'Elazig'),
(3344,1,'Erzincan'),
(3345,1,'Erzurum'),
(3346,1,'Eskisehir'),
(3347,1,'Gaziantep'),
(3348,1,'Giresun'),
(3349,1,'Gumushane'),
(3350,1,'Hakkari'),
(3351,1,'Hatay'),
(3352,1,'Igdir'),
(3353,1,'Isparta'),
(3354,1,'Istanbul'),
(3355,1,'Izmir'),
(3356,1,'Kahramanmaras'),
(3357,1,'Karabuk'),
(3358,1,'Karaman'),
(3359,1,'Kars'),
(3360,1,'Kastamonu'),
(3361,1,'Kayseri'),
(3362,1,'Kilis'),
(3363,1,'Kirikkale'),
(3364,1,'Kirklareli'),
(3365,1,'Kirsehir'),
(3366,1,'Kocaeli'),
(3367,1,'Konya'),
(3368,1,'Kutahya'),
(3369,1,'Malatya'),
(3370,1,'Manisa'),
(3371,1,'Mardin'),
(3372,1,'Mersin'),
(3373,1,'Mugla'),
(3374,1,'Mus'),
(3375,1,'Nevsehir'),
(3376,1,'Nigde'),
(3377,1,'Ordu'),
(3378,1,'Osmaniye'),
(3379,1,'Rize'),
(3380,1,'Sakarya'),
(3381,1,'Samsun'),
(3382,1,'Sanliurfa'),
(3383,1,'Siirt'),
(3384,1,'Sinop'),
(3385,1,'Sirnak'),
(3386,1,'Sivas'),
(3387,1,'Tekirdag'),
(3388,1,'Tokat'),
(3389,1,'Trabzon'),
(3390,1,'Tunceli'),
(3391,1,'Usak'),
(3392,1,'Van'),
(3393,1,'Yalova'),
(3394,1,'Yozgat'),
(3395,1,'Zonguldak'),
(3396,1,'Ahal Welayaty'),
(3397,1,'Balkan Welayaty'),
(3398,1,'Dashhowuz Welayaty'),
(3399,1,'Lebap Welayaty'),
(3400,1,'Mary Welayaty'),
(3401,1,'Ambergris Cays'),
(3402,1,'Dellis Cay'),
(3403,1,'French Cay'),
(3404,1,'Little Water Cay'),
(3405,1,'Parrot Cay'),
(3406,1,'Pine Cay'),
(3407,1,'Salt Cay'),
(3408,1,'Grand Turk'),
(3409,1,'South Caicos'),
(3410,1,'East Caicos'),
(3411,1,'Middle Caicos'),
(3412,1,'North Caicos'),
(3413,1,'Providenciales'),
(3414,1,'West Caicos'),
(3415,1,'Nanumanga'),
(3416,1,'Niulakita'),
(3417,1,'Niutao'),
(3418,1,'Funafuti'),
(3419,1,'Nanumea'),
(3420,1,'Nui'),
(3421,1,'Nukufetau'),
(3422,1,'Nukulaelae'),
(3423,1,'Vaitupu'),
(3424,1,'Kalangala'),
(3425,1,'Kampala'),
(3426,1,'Kayunga'),
(3427,1,'Kiboga'),
(3428,1,'Luwero'),
(3429,1,'Masaka'),
(3430,1,'Mpigi'),
(3431,1,'Mubende'),
(3432,1,'Mukono'),
(3433,1,'Nakasongola'),
(3434,1,'Rakai'),
(3435,1,'Sembabule'),
(3436,1,'Wakiso'),
(3437,1,'Bugiri'),
(3438,1,'Busia'),
(3439,1,'Iganga'),
(3440,1,'Jinja'),
(3441,1,'Kaberamaido'),
(3442,1,'Kamuli'),
(3443,1,'Kapchorwa'),
(3444,1,'Katakwi'),
(3445,1,'Kumi'),
(3446,1,'Mayuge'),
(3447,1,'Mbale'),
(3448,1,'Pallisa'),
(3449,1,'Sironko'),
(3450,1,'Soroti'),
(3451,1,'Tororo'),
(3452,1,'Adjumani'),
(3453,1,'Apac'),
(3454,1,'Arua'),
(3455,1,'Gulu'),
(3456,1,'Kitgum'),
(3457,1,'Kotido'),
(3458,1,'Lira'),
(3459,1,'Moroto'),
(3460,1,'Moyo'),
(3461,1,'Nakapiripirit'),
(3462,1,'Nebbi'),
(3463,1,'Pader'),
(3464,1,'Yumbe'),
(3465,1,'Bundibugyo'),
(3466,1,'Bushenyi'),
(3467,1,'Hoima'),
(3468,1,'Kabale'),
(3469,1,'Kabarole'),
(3470,1,'Kamwenge'),
(3471,1,'Kanungu'),
(3472,1,'Kasese'),
(3473,1,'Kibaale'),
(3474,1,'Kisoro'),
(3475,1,'Kyenjojo'),
(3476,1,'Masindi'),
(3477,1,'Mbarara'),
(3478,1,'Ntungamo'),
(3479,1,'Rukungiri'),
(3480,1,'Cherkasy'),
(3481,1,'Chernihiv'),
(3482,1,'Chernivtsi'),
(3483,1,'Crimea'),
(3484,1,'Dnipropetrovs\'k'),
(3485,1,'Donets\'k'),
(3486,1,'Ivano-Frankivs\'k'),
(3487,1,'Kharkiv'),
(3488,1,'Khmel\'nyts\'kyy'),
(3489,1,'Kirovohrad'),
(3490,1,'Kyiv'),
(3491,1,'Kherson'),
(3492,1,'Luhans\'k'),
(3493,1,'L\'viv'),
(3494,1,'Mykolayiv'),
(3495,1,'Odesa'),
(3496,1,'Poltava'),
(3497,1,'Rivne'),
(3498,1,'Sevastopol'),
(3499,1,'Sumy'),
(3500,1,'Ternopil\''),
(3501,1,'Vinnytsya'),
(3502,1,'Volyn\''),
(3503,1,'Zakarpattya'),
(3504,1,'Zaporizhzhya'),
(3505,1,'Zhytomyr'),
(3506,1,'Abu Zaby'),
(3507,1,'\'Ajman'),
(3508,1,'Al Fujayrah'),
(3509,1,'Ash Shariqah'),
(3510,1,'Dubayy'),
(3511,1,'R\'as al Khaymah'),
(3512,1,'Umm al Qaywayn'),
(3513,1,'Aberdeen'),
(3514,1,'Aberdeenshire'),
(3515,1,'Anglesey'),
(3516,1,'Angus'),
(3517,1,'Argyll and Bute'),
(3518,1,'Bedfordshire'),
(3519,1,'Berkshire'),
(3520,1,'Blaenau Gwent'),
(3521,1,'Bridgend'),
(3522,1,'Bristol'),
(3523,1,'Buckinghamshire'),
(3524,1,'Caerphilly'),
(3525,1,'Cambridgeshire'),
(3526,1,'Cardiff'),
(3527,1,'Carmarthenshire'),
(3528,1,'Ceredigion'),
(3529,1,'Cheshire'),
(3530,1,'Clackmannanshire'),
(3531,1,'Conwy'),
(3532,1,'Cornwall'),
(3533,1,'Denbighshire'),
(3534,1,'Derbyshire'),
(3535,1,'Devon'),
(3536,1,'Dorset'),
(3537,1,'Dumfries and Galloway'),
(3538,1,'Dundee'),
(3539,1,'Durham'),
(3540,1,'East Ayrshire'),
(3541,1,'East Dunbartonshire'),
(3542,1,'East Lothian'),
(3543,1,'East Renfrewshire'),
(3544,1,'East Riding of Yorkshire'),
(3545,1,'East Sussex'),
(3546,1,'Edinburgh'),
(3547,1,'Essex'),
(3548,1,'Falkirk'),
(3549,1,'Fife'),
(3550,1,'Flintshire'),
(3551,1,'Glasgow'),
(3552,1,'Gloucestershire'),
(3553,1,'Greater London'),
(3554,1,'Greater Manchester'),
(3555,1,'Gwynedd'),
(3556,1,'Hampshire'),
(3557,1,'Herefordshire'),
(3558,1,'Hertfordshire'),
(3559,1,'Highlands'),
(3560,1,'Inverclyde'),
(3561,1,'Isle of Wight'),
(3562,1,'Kent'),
(3563,1,'Lancashire'),
(3564,1,'Leicestershire'),
(3565,1,'Lincolnshire'),
(3566,1,'Merseyside'),
(3567,1,'Merthyr Tydfil'),
(3568,1,'Midlothian'),
(3569,1,'Monmouthshire'),
(3570,1,'Moray'),
(3571,1,'Neath Port Talbot'),
(3572,1,'Newport'),
(3573,1,'Norfolk'),
(3574,1,'North Ayrshire'),
(3575,1,'North Lanarkshire'),
(3576,1,'North Yorkshire'),
(3577,1,'Northamptonshire'),
(3578,1,'Northumberland'),
(3579,1,'Nottinghamshire'),
(3580,1,'Orkney Islands'),
(3581,1,'Oxfordshire'),
(3582,1,'Pembrokeshire'),
(3583,1,'Perth and Kinross'),
(3584,1,'Powys'),
(3585,1,'Renfrewshire'),
(3586,1,'Rhondda Cynon Taff'),
(3587,1,'Rutland'),
(3588,1,'Scottish Borders'),
(3589,1,'Shetland Islands'),
(3590,1,'Shropshire'),
(3591,1,'Somerset'),
(3592,1,'South Ayrshire'),
(3593,1,'South Lanarkshire'),
(3594,1,'South Yorkshire'),
(3595,1,'Staffordshire'),
(3596,1,'Stirling'),
(3597,1,'Suffolk'),
(3598,1,'Surrey'),
(3599,1,'Swansea'),
(3600,1,'Torfaen'),
(3601,1,'Tyne and Wear'),
(3602,1,'Vale of Glamorgan'),
(3603,1,'Warwickshire'),
(3604,1,'West Dunbartonshire'),
(3605,1,'West Lothian'),
(3606,1,'West Midlands'),
(3607,1,'West Sussex'),
(3608,1,'West Yorkshire'),
(3609,1,'Western Isles'),
(3610,1,'Wiltshire'),
(3611,1,'Worcestershire'),
(3612,1,'Wrexham'),
(3613,1,'Alabama'),
(3614,1,'Alaska'),
(3615,1,'American Samoa'),
(3616,1,'Arizona'),
(3617,1,'Arkansas'),
(3618,1,'Armed Forces Africa'),
(3619,1,'Armed Forces Americas'),
(3620,1,'Armed Forces Canada'),
(3621,1,'Armed Forces Europe'),
(3622,1,'Armed Forces Middle East'),
(3623,1,'Armed Forces Pacific'),
(3624,1,'California'),
(3625,1,'Colorado'),
(3626,1,'Connecticut'),
(3627,1,'Delaware'),
(3628,1,'District of Columbia'),
(3629,1,'Federated States Of Micronesia'),
(3630,1,'Florida'),
(3631,1,'Georgia'),
(3632,1,'Guam'),
(3633,1,'Hawaii'),
(3634,1,'Idaho'),
(3635,1,'Illinois'),
(3636,1,'Indiana'),
(3637,1,'Iowa'),
(3638,1,'Kansas'),
(3639,1,'Kentucky'),
(3640,1,'Louisiana'),
(3641,1,'Maine'),
(3642,1,'Marshall Islands'),
(3643,1,'Maryland'),
(3644,1,'Massachusetts'),
(3645,1,'Michigan'),
(3646,1,'Minnesota'),
(3647,1,'Mississippi'),
(3648,1,'Missouri'),
(3649,1,'Montana'),
(3650,1,'Nebraska'),
(3651,1,'Nevada'),
(3652,1,'New Hampshire'),
(3653,1,'New Jersey'),
(3654,1,'New Mexico'),
(3655,1,'New York'),
(3656,1,'North Carolina'),
(3657,1,'North Dakota'),
(3658,1,'Northern Mariana Islands'),
(3659,1,'Ohio'),
(3660,1,'Oklahoma'),
(3661,1,'Oregon'),
(3662,1,'Palau'),
(3663,1,'Pennsylvania'),
(3664,1,'Puerto Rico'),
(3665,1,'Rhode Island'),
(3666,1,'South Carolina'),
(3667,1,'South Dakota'),
(3668,1,'Tennessee'),
(3669,1,'Texas'),
(3670,1,'Utah'),
(3671,1,'Vermont'),
(3672,1,'Virgin Islands'),
(3673,1,'Virginia'),
(3674,1,'Washington'),
(3675,1,'West Virginia'),
(3676,1,'Wisconsin'),
(3677,1,'Wyoming'),
(3678,1,'Baker Island'),
(3679,1,'Howland Island'),
(3680,1,'Jarvis Island'),
(3681,1,'Johnston Atoll'),
(3682,1,'Kingman Reef'),
(3683,1,'Midway Atoll'),
(3684,1,'Navassa Island'),
(3685,1,'Palmyra Atoll'),
(3686,1,'Wake Island'),
(3687,1,'Artigas'),
(3688,1,'Canelones'),
(3689,1,'Cerro Largo'),
(3690,1,'Colonia'),
(3691,1,'Durazno'),
(3692,1,'Flores'),
(3693,1,'Florida'),
(3694,1,'Lavalleja'),
(3695,1,'Maldonado'),
(3696,1,'Montevideo'),
(3697,1,'Paysandu'),
(3698,1,'Rio Negro'),
(3699,1,'Rivera'),
(3700,1,'Rocha'),
(3701,1,'Salto'),
(3702,1,'San Jose'),
(3703,1,'Soriano'),
(3704,1,'Tacuarembo'),
(3705,1,'Treinta y Tres'),
(3706,1,'Andijon'),
(3707,1,'Buxoro'),
(3708,1,'Farg\'ona'),
(3709,1,'Jizzax'),
(3710,1,'Namangan'),
(3711,1,'Navoiy'),
(3712,1,'Qashqadaryo'),
(3713,1,'Qoraqalpog\'iston Republikasi'),
(3714,1,'Samarqand'),
(3715,1,'Sirdaryo'),
(3716,1,'Surxondaryo'),
(3717,1,'Toshkent City'),
(3718,1,'Toshkent Region'),
(3719,1,'Xorazm'),
(3720,1,'Malampa'),
(3721,1,'Penama'),
(3722,1,'Sanma'),
(3723,1,'Shefa'),
(3724,1,'Tafea'),
(3725,1,'Torba'),
(3726,1,'Amazonas'),
(3727,1,'Anzoategui'),
(3728,1,'Apure'),
(3729,1,'Aragua'),
(3730,1,'Barinas'),
(3731,1,'Bolivar'),
(3732,1,'Carabobo'),
(3733,1,'Cojedes'),
(3734,1,'Delta Amacuro'),
(3735,1,'Dependencias Federales'),
(3736,1,'Distrito Federal'),
(3737,1,'Falcon'),
(3738,1,'Guarico'),
(3739,1,'Lara'),
(3740,1,'Merida'),
(3741,1,'Miranda'),
(3742,1,'Monagas'),
(3743,1,'Nueva Esparta'),
(3744,1,'Portuguesa'),
(3745,1,'Sucre'),
(3746,1,'Tachira'),
(3747,1,'Trujillo'),
(3748,1,'Vargas'),
(3749,1,'Yaracuy'),
(3750,1,'Zulia'),
(3751,1,'An Giang'),
(3752,1,'Bac Giang'),
(3753,1,'Bac Kan'),
(3754,1,'Bac Lieu'),
(3755,1,'Bac Ninh'),
(3756,1,'Ba Ria-Vung Tau'),
(3757,1,'Ben Tre'),
(3758,1,'Binh Dinh'),
(3759,1,'Binh Duong'),
(3760,1,'Binh Phuoc'),
(3761,1,'Binh Thuan'),
(3762,1,'Ca Mau'),
(3763,1,'Can Tho'),
(3764,1,'Cao Bang'),
(3765,1,'Dak Lak'),
(3766,1,'Dak Nong'),
(3767,1,'Da Nang'),
(3768,1,'Dien Bien'),
(3769,1,'Dong Nai'),
(3770,1,'Dong Thap'),
(3771,1,'Gia Lai'),
(3772,1,'Ha Giang'),
(3773,1,'Hai Duong'),
(3774,1,'Hai Phong'),
(3775,1,'Ha Nam'),
(3776,1,'Ha Noi'),
(3777,1,'Ha Tay'),
(3778,1,'Ha Tinh'),
(3779,1,'Hoa Binh'),
(3780,1,'Ho Chi Minh City'),
(3781,1,'Hau Giang'),
(3782,1,'Hung Yen'),
(3783,1,'Saint Croix'),
(3784,1,'Saint John'),
(3785,1,'Saint Thomas'),
(3786,1,'Alo'),
(3787,1,'Sigave'),
(3788,1,'Wallis'),
(3789,1,'Abyan'),
(3790,1,'Adan'),
(3791,1,'Amran'),
(3792,1,'Al Bayda'),
(3793,1,'Ad Dali'),
(3794,1,'Dhamar'),
(3795,1,'Hadramawt'),
(3796,1,'Hajjah'),
(3797,1,'Al Hudaydah'),
(3798,1,'Ibb'),
(3799,1,'Al Jawf'),
(3800,1,'Lahij'),
(3801,1,'Ma\'rib'),
(3802,1,'Al Mahrah'),
(3803,1,'Al Mahwit'),
(3804,1,'Sa\'dah'),
(3805,1,'San\'a'),
(3806,1,'Shabwah'),
(3807,1,'Ta\'izz'),
(3808,1,'Kosovo'),
(3809,1,'Montenegro'),
(3810,1,'Serbia'),
(3811,1,'Vojvodina'),
(3812,1,'Bas-Congo'),
(3813,1,'Bandundu'),
(3814,1,'Equateur'),
(3815,1,'Katanga'),
(3816,1,'Kasai-Oriental'),
(3817,1,'Kinshasa'),
(3818,1,'Kasai-Occidental'),
(3819,1,'Maniema'),
(3820,1,'Nord-Kivu'),
(3821,1,'Orientale'),
(3822,1,'Sud-Kivu'),
(3823,1,'Central'),
(3824,1,'Copperbelt'),
(3825,1,'Eastern'),
(3826,1,'Luapula'),
(3827,1,'Lusaka'),
(3828,1,'Northern'),
(3829,1,'North-Western'),
(3830,1,'Southern'),
(3831,1,'Western'),
(3832,1,'Bulawayo'),
(3833,1,'Harare'),
(3834,1,'Manicaland'),
(3835,1,'Mashonaland Central'),
(3836,1,'Mashonaland East'),
(3837,1,'Mashonaland West'),
(3838,1,'Masvingo'),
(3839,1,'Matabeleland North'),
(3840,1,'Matabeleland South'),
(3841,1,'Midlands'),
(3861,1,'Campobasso'),
(3862,1,'Carbonia-Iglesias'),
(3863,1,'Caserta'),
(3864,1,'Catania'),
(3865,1,'Catanzaro'),
(3866,1,'Chieti'),
(3867,1,'Como'),
(3868,1,'Cosenza'),
(3869,1,'Cremona'),
(3870,1,'Crotone'),
(3871,1,'Cuneo'),
(3872,1,'Enna'),
(3873,1,'Ferrara'),
(3874,1,'Firenze'),
(3875,1,'Foggia'),
(3876,1,'Forli-Cesena'),
(3877,1,'Frosinone'),
(3878,1,'Genova'),
(3879,1,'Gorizia'),
(3880,1,'Grosseto'),
(3881,1,'Imperia'),
(3882,1,'Isernia'),
(3883,1,'L&#39;Aquila'),
(3884,1,'La Spezia'),
(3885,1,'Latina'),
(3886,1,'Lecce'),
(3887,1,'Lecco'),
(3888,1,'Livorno'),
(3889,1,'Lodi'),
(3890,1,'Lucca'),
(3891,1,'Macerata'),
(3892,1,'Mantova'),
(3893,1,'Massa-Carrara'),
(3894,1,'Matera'),
(3895,1,'Medio Campidano'),
(3896,1,'Messina'),
(3897,1,'Milano'),
(3898,1,'Modena'),
(3899,1,'Napoli'),
(3900,1,'Novara'),
(3901,1,'Nuoro'),
(3902,1,'Ogliastra'),
(3903,1,'Olbia-Tempio'),
(3904,1,'Oristano'),
(3905,1,'Padova'),
(3906,1,'Palermo'),
(3907,1,'Parma'),
(3908,1,'Pavia'),
(3909,1,'Perugia'),
(3910,1,'Pesaro e Urbino'),
(3911,1,'Pescara'),
(3912,1,'Piacenza'),
(3913,1,'Pisa'),
(3914,1,'Pistoia'),
(3915,1,'Pordenone'),
(3916,1,'Potenza'),
(3917,1,'Prato'),
(3918,1,'Ragusa'),
(3919,1,'Ravenna'),
(3920,1,'Reggio Calabria'),
(3921,1,'Reggio Emilia'),
(3922,1,'Rieti'),
(3923,1,'Rimini'),
(3924,1,'Roma'),
(3925,1,'Rovigo'),
(3926,1,'Salerno'),
(3927,1,'Sassari'),
(3928,1,'Savona'),
(3929,1,'Siena'),
(3930,1,'Siracusa'),
(3931,1,'Sondrio'),
(3932,1,'Taranto'),
(3933,1,'Teramo'),
(3934,1,'Terni'),
(3935,1,'Torino'),
(3936,1,'Trapani'),
(3937,1,'Trento'),
(3938,1,'Treviso'),
(3939,1,'Trieste'),
(3940,1,'Udine'),
(3941,1,'Varese'),
(3942,1,'Venezia'),
(3943,1,'Verbano-Cusio-Ossola'),
(3944,1,'Vercelli'),
(3945,1,'Verona'),
(3946,1,'Vibo Valentia'),
(3947,1,'Vicenza'),
(3948,1,'Viterbo'),
(3949,1,'Antrim'),
(3950,1,'Armagh'),
(3951,1,'Down'),
(3952,1,'Fermanagh'),
(3953,1,'Derry'),
(3954,1,'Tyrone');


--
-- DDL for table `zone_to_locations`
--
DROP TABLE IF EXISTS `ac_zones_to_locations`;
CREATE TABLE `ac_zones_to_locations` (
  `zone_to_location_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`zone_to_location_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_zones_to_locations_idx` ON `ac_zones_to_locations` ( `country_id`, `zone_id`, `location_id` );

--
-- Dumping data for table `ac_zones_to_locations`
--

INSERT INTO `ac_zones_to_locations` (`zone_to_location_id`, `country_id`, `zone_id`, `location_id`, `date_added`)
VALUES
	(66,223,3677,1,now()),
	(65,223,3676,1,now()),
	(64,223,3675,1,now()),
	(63,223,3674,1,now()),
	(62,223,3673,1,now()),
	(61,223,3672,1,now()),
	(60,223,3671,1,now()),
	(59,223,3670,1,now()),
	(58,223,3669,1,now()),
	(57,223,3668,1,now()),
	(56,223,3667,1,now()),
	(55,223,3666,1,now()),
	(54,223,3665,1,now()),
	(53,223,3664,1,now()),
	(52,223,3663,1,now()),
	(51,223,3662,1,now()),
	(50,223,3661,1,now()),
	(49,223,3660,1,now()),
	(48,223,3659,1,now()),
	(47,223,3658,1,now()),
	(46,223,3657,1,now()),
	(45,223,3656,1,now()),
	(44,223,3655,1,now()),
	(43,223,3654,1,now()),
	(42,223,3653,1,now()),
	(41,223,3652,1,now()),
	(40,223,3651,1,now()),
	(39,223,3650,1,now()),
	(38,223,3649,1,now()),
	(37,223,3648,1,now()),
	(36,223,3647,1,now()),
	(35,223,3646,1,now()),
	(34,223,3645,1,now()),
	(33,223,3644,1,now()),
	(32,223,3643,1,now()),
	(31,223,3642,1,now()),
	(30,223,3641,1,now()),
	(29,223,3640,1,now()),
	(28,223,3639,1,now()),
	(27,223,3638,1,now()),
	(26,223,3637,1,now()),
	(25,223,3636,1,now()),
	(24,223,3635,1,now()),
	(23,223,3634,1,now()),
	(22,223,3633,1,now()),
	(21,223,3632,1,now()),
	(20,223,3631,1,now()),
	(19,223,3630,1,now()),
	(18,223,3629,1,now()),
	(17,223,3628,1,now()),
	(16,223,3627,1,now()),
	(15,223,3626,1,now()),
	(14,223,3625,1,now()),
	(13,223,3624,1,now()),
	(12,223,3623,1,now()),
	(11,223,3622,1,now()),
	(10,223,3621,1,now()),
	(9,223,3620,1,now()),
	(8,223,3619,1,now()),
	(7,223,3618,1,now()),
	(6,223,3617,1,now()),
	(5,223,3616,1,now()),
	(4,223,3615,1,now()),
	(3,223,3614,1,now()),
	(2,223,3613,1,now())
;

--
-- DDL for table `pages`
--
DROP TABLE IF EXISTS `ac_pages`;
CREATE TABLE `ac_pages` (
  `page_id` int(10) NOT NULL auto_increment,
  `parent_page_id` int(10) NOT NULL DEFAULT '0',  
  `controller` varchar(100) NOT NULL,
  `key_param` varchar(40) NOT NULL default '', -- Example product_id=10 identifies uniqe product page  
  `key_value` varchar(40) NOT NULL default '', -- Example product_id=10 identifies uniqe product page
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (`page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
CREATE UNIQUE INDEX `ac_pages_idx`
ON `ac_pages` ( `page_id`, `controller`, `key_param`, `key_value` );

--
-- Dumping data for table `pages`
--

INSERT INTO `ac_pages` (`page_id`, `parent_page_id`, `controller`, `key_param`, `key_value`, `date_added`) VALUES
(1, 0, 'generic', '', '', now() ),
(2, 0, 'pages/index/home', '', '', now() ),
(3, 0, 'pages/checkout', '', '', now() ),
(4, 0, 'pages/account/login', '', '', now() ),
(5, 0, 'pages/product/product', '', '', now()),
(10, 0, 'pages/index/maintenance', '', '', now() ),
(11, 0, 'pages/account', '', '', now() );


--
-- DDL for table `page_descriptions`
--

DROP TABLE IF EXISTS `ac_page_descriptions`;
CREATE TABLE `ac_page_descriptions` (
  `page_id` int(10) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'translatable',
  `title` varchar(255) NOT NULL COMMENT 'translatable',
  `seo_url` varchar(100) NOT NULL DEFAULT '',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  `content` text DEFAULT NULL COMMENT 'translatable', -- Contain the page details if custom content
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`page_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_page_descriptions` (`page_id`, `language_id`, `name`, `title`, `seo_url`, `keywords`, `description`, `content`, `date_added`) VALUES
(1, 1, 'تمام صفحات دیگر', '', '', '', '', '', now() ),
(2, 1, 'صفحه اصلی', '', '', '', '', '', now() ),
(3, 1, 'صفحه پرداخت', '', '', '', '', '', now() ),
(4, 1, 'صفحه ورود', '', '', '', '', '', now() ),
(5, 1, 'صفحه پیش فرض محصولات', '', '', '', '', '', now() ),
(10, 1, 'تعمیر و نگهداری صفحه', '', '', '', '', '', now() ),
(11, 1, 'صفحه حساب مشتری', '', '', '', '', '', now() );

--
-- DDL for table `contents`
--
DROP TABLE IF EXISTS `ac_contents`;
CREATE TABLE `ac_contents` (
    `content_id` int(11) NOT NULL AUTO_INCREMENT,
	`parent_content_id` int(11) NOT NULL DEFAULT 0,
    `sort_order` int(3) NOT NULL DEFAULT '0',
    `status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`,`parent_content_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `contents`
--

INSERT INTO `ac_contents` (`content_id`, `sort_order`, `status`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1);

--
-- DDL for table `content_descriptions`
--

DROP TABLE IF EXISTS `ac_content_descriptions`;
CREATE TABLE `ac_content_descriptions` (
  `content_id` int(10) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'translatable',
  `title` varchar(255) NOT NULL COMMENT 'translatable',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  `content` text NOT NULL COMMENT 'translatable', -- Contain the page details if custom content
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`content_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_content_descriptions` (`content_id`, `language_id`, `name`, `title`, `description`, `content`, `date_added`)
VALUES
(1, 1, 'درباره ما', 'درباره ما', 'برخی از توضیحات', 'متن در مورد فروشگاه شما', now() ),
(2, 1, 'حریم خصوصی', 'حریم خصوصی', 'برخی از توضیحات', 'متنی در مورد سیاست حفظ حریم خصوصی', now()),
(3, 1, 'سیاست بازگشت', 'سیاست بازگشت', 'برخی از توضیحات', 'some text about return policy', now()),
(4, 1, 'حمل و نقل', 'حمل و نقل', 'برخی از توضیحات', 'some text about shipping', now());

--
-- DDL for table `content_to_store`
--
DROP TABLE IF EXISTS `ac_contents_to_stores`;
CREATE TABLE `ac_contents_to_stores` (
  `content_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `blocks`
--
DROP TABLE IF EXISTS `ac_blocks`;
CREATE TABLE `ac_blocks` (
  `block_id` int(10) NOT NULL auto_increment,
  `block_txt_id` varchar(40) NOT NULL,
  `controller` varchar(120) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (`block_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_blocks` (`block_id`, `block_txt_id`, `controller`, `date_added`) VALUES
(1, 'header', 'common/header', now() ),
(2, 'header_bottom', 'common/header_bottom', now() ),
(3, 'column_left', 'common/column_left', now() ),
(4, 'content_top', 'common/content_top', now() ),
(5, 'content_bottom', 'common/content_bottom', now() ),
(6, 'column_right', 'common/column_right', now() ),
(7, 'footer_top', 'common/footer_top', now() ),
(8, 'footer', 'common/footer', now() ),
(9, 'category', 'blocks/category', now() ),
(10, 'manufacturer', 'blocks/manufacturer', now() ),
(11, 'content', 'blocks/content', now() ),
(12, 'latest', 'blocks/latest', now() ),
(13, 'language', 'blocks/language', now() ),
(14, 'currency', 'blocks/currency', now() ),
(15, 'cart', 'blocks/cart', now() ),
(16, 'order_summary', 'blocks/order_summary', now() ),
(17, 'html_block', 'blocks/html_block', now() ),
(18, 'bestsellers', 'blocks/bestseller', now() ),
(19, 'featured', 'blocks/featured', now() ),
(20, 'listing_block', 'blocks/listing_block', now() ),
(21, 'donate', 'blocks/donate', now() ),
(22, 'special', 'blocks/special', now() ),
(23, 'banner_block', 'blocks/banner_block', now() ),
(24, 'credit_cards', 'blocks/credit_cards', now() ),
(25, 'newsletter_signup', 'blocks/newsletter_signup', now() ), 
(26, 'search', 'blocks/search', now() ),
(27, 'menu', 'blocks/menu', now() ),
(28, 'breadcrumbs', 'blocks/breadcrumbs', now() ), 
(29, 'account', 'blocks/account', now()),
(30, 'custom_form_block', 'blocks/custom_form_block', now() ),
(31, 'customer', 'blocks/customer', now() );

--
-- DDL for table `ac_custom_blocks`
--

DROP TABLE IF EXISTS `ac_custom_blocks`;
CREATE TABLE `ac_custom_blocks` (
  `custom_block_id` int(10) NOT NULL auto_increment,
  `block_id` int(10) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`custom_block_id`, `block_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- DDL for table `ac_custom_lists`
--

DROP TABLE IF EXISTS `ac_custom_lists`;
CREATE TABLE `ac_custom_lists` (
	`rowid` INT(11) NOT NULL AUTO_INCREMENT,
  `custom_block_id` int(10) NOT NULL,
  `data_type` varchar(70) NOT NULL,
  `id` int(10) NOT NULL,
  `sort_order` int(10) NOT NULL DEFAULT 0,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`rowid`),
	INDEX `ac_custom_block_id_list_idx` (`custom_block_id` )
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- DDL for table `block_descriptions`
--

DROP TABLE IF EXISTS `ac_block_descriptions`;
CREATE TABLE `ac_block_descriptions` (
  `block_description_id` int(10) NOT NULL auto_increment,
  `custom_block_id` int(10) NOT NULL,
  `language_id` int(10) NOT NULL,
  `block_wrapper` varchar(255) NOT NULL default '0',
  `block_framed` tinyint(1) DEFAULT '1',
  `name` varchar(255) NOT NULL COMMENT 'translatable',
  `title` varchar(255) NOT NULL COMMENT 'translatable',  
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  `content` text NOT NULL DEFAULT '', -- Contain the block details if custom content
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_description_id`, `custom_block_id`, `language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `block_templates`
--
	
DROP TABLE IF EXISTS `ac_block_templates`;
CREATE TABLE `ac_block_templates` (
  `block_id` int(10) NOT NULL auto_increment,
  `parent_block_id` int(10) NOT NULL DEFAULT 0, -- Placeholder where this block can be placed. 0 - any location
  `template` varchar(100) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (`block_id`, `parent_block_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_block_templates` (`block_id`, `parent_block_id`, `template`, `date_added`) VALUES
(15, 1, 'blocks/cart_top.tpl', now() ),
(15, 6, 'blocks/cart.tpl', now() ),
(9, 1, 'blocks/category_top.tpl', now()),
(9, 2, 'blocks/category_top.tpl', now()),
(9, 3, 'blocks/category.tpl', now() ),
(9, 6, 'blocks/category.tpl', now() ),
(9, 7, 'blocks/category_bottom.tpl', now() ),
(9, 8, 'blocks/category_bottom.tpl', now() ),

(10, 3, 'blocks/manufacturer.tpl', now() ),
(10, 6, 'blocks/manufacturer.tpl', now() ),
(11, 3, 'blocks/content.tpl', now() ),
(11, 1, 'blocks/content_header.tpl', now() ),
(11, 6, 'blocks/content.tpl', now() ),
(11, 8, 'blocks/content_footer.tpl', now() ),
(12, 3, 'blocks/latest.tpl', now() ),
(12, 6, 'blocks/latest.tpl', now() ),
(12, 5, 'blocks/latest_home.tpl', now() ),
(12, 4, 'blocks/latest_home.tpl', now()),
(13, 1, 'blocks/language.tpl', now() ),
(14, 1, 'blocks/currency.tpl', now() ),
(16, 6, 'blocks/order_summary.tpl', now() ),
(17, 1, 'blocks/html_block_header.tpl', now() ),
(17, 2, 'blocks/html_block_content.tpl', now() ),
(17, 3, 'blocks/html_block.tpl', now() ),
(17, 4, 'blocks/html_block_content.tpl', now() ),
(17, 5, 'blocks/html_block_content.tpl', now() ),
(17, 6, 'blocks/html_block.tpl', now() ),
(17, 7, 'blocks/html_block_content.tpl', now() ),
(17, 8, 'blocks/html_block_footer.tpl', now() ),
(18, 3, 'blocks/bestseller.tpl', now() ),
(18, 6, 'blocks/bestseller.tpl', now() ),
(18, 5, 'blocks/bestseller_home.tpl', now() ),
(19, 3, 'blocks/featured.tpl', now() ),
(19, 6, 'blocks/featured.tpl', now() ),
(19, 5, 'blocks/featured_home.tpl', now() ),
(20, 1, 'blocks/listing_block_header.tpl', now() ),
(20, 2, 'blocks/listing_block_header_bottom.tpl', now() ),
(20, 3, 'blocks/listing_block_column_left.tpl', now() ),
(20, 4, 'blocks/listing_block_content_top.tpl', now() ),
(20, 5, 'blocks/listing_block_content_bottom.tpl', now() ),
(20, 6, 'blocks/listing_block_column_right.tpl', now() ),
(20, 7, 'blocks/listing_block_footer_top.tpl', now() ),
(20, 8, 'blocks/listing_block_footer.tpl', now() ),
(21, 0, 'blocks/donate.tpl', now() ),
(22, 3, 'blocks/special.tpl', now() ),
(22, 5, 'blocks/special_home.tpl', now() ),
(22, 6, 'blocks/special.tpl', now() ),
(23, 1, 'blocks/banner_block_header.tpl', NOW() ),
(23, 2, 'blocks/banner_block_content.tpl', NOW() ),
(23, 3, 'blocks/banner_block.tpl', NOW() ),
(23, 4, 'blocks/banner_block_content.tpl', NOW() ),
(23, 5, 'blocks/banner_block_content.tpl', NOW() ),
(23, 6, 'blocks/banner_block.tpl', NOW() ),
(23, 7, 'blocks/banner_block_content.tpl', NOW() ),
(23, 8, 'blocks/banner_block_header.tpl', NOW() ),
(24, 8, 'blocks/credit_cards.tpl', now() ),
(25, 1, 'blocks/newsletter_signup_header.tpl', now() ),
(25, 2, 'blocks/newsletter_signup_header_bottom.tpl', now() ),
(25, 3, 'blocks/newsletter_signup_column_left.tpl', now() ),
(25, 4, 'blocks/newsletter_signup_content_top.tpl', now() ),
(25, 5, 'blocks/newsletter_signup_content_bottom.tpl', now() ),
(25, 6, 'blocks/newsletter_signup_column_right.tpl', now() ),
(25, 7, 'blocks/newsletter_signup_footer_top.tpl', now() ),
(25, 8, 'blocks/newsletter_signup_footer.tpl', now() ),
(26, 1, 'blocks/search_top.tpl', now() ),
(26, 2, 'blocks/search_top.tpl', now() ),
(26, 3, 'blocks/search.tpl', now() ),
(26, 6, 'blocks/search.tpl', now() ),
(27, 1, 'blocks/menu_top.tpl', now() ),
(27, 8, 'blocks/menu_bottom.tpl', now() ),
(27, 3, 'blocks/menu.tpl', now() ),
(27, 6, 'blocks/menu.tpl', now() ),
(28, 0, 'blocks/breadcrumbs.tpl', now() ),
(29, 0, 'blocks/account.tpl', now() ),
(30, 1, 'blocks/custom_form_block_header.tpl', NOW() ),
(30, 2, 'blocks/custom_form_block_content.tpl', NOW() ),
(30, 3, 'blocks/custom_form_block.tpl', NOW() ),
(30, 4, 'blocks/custom_form_block_content.tpl', NOW() ),
(30, 5, 'blocks/custom_form_block_content.tpl', NOW() ),
(30, 6, 'blocks/custom_form_block.tpl', NOW() ),
(30, 7, 'blocks/custom_form_block_content.tpl', NOW() ),
(30, 8, 'blocks/custom_form_block_header.tpl', NOW() ),
(31, 0, 'blocks/customer.tpl', now() )
;

--
-- DDL for table `layouts`
--

DROP TABLE IF EXISTS `ac_layouts`;
CREATE TABLE `ac_layouts` (
  `layout_id` int(10) NOT NULL auto_increment,
  `template_id` varchar(100) NOT NULL,
  `layout_name` varchar(255) NOT NULL default '',
  `layout_type` smallint(1) NOT NULL default '0', -- 0 Default, 1 Active layout, 2 draft layout, 3 template layout
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (`layout_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_layouts` (`layout_id`, `template_id`, `layout_type`, `layout_name`, `date_added`) VALUES 
(11, 'default', 0, 'Default Page Layout',  now()),
(12, 'default', 1, 'Home Page',  now()),
(13, 'default', 1, 'Login Page',  now()),
(14, 'default', 1, 'Default Product Page',  now()),
(15, 'default', 1, 'Checkout Pages', now()),
(16, 'default', 1, 'Product Listing Page', now()),
(17, 'default', 1, 'Maintanance Page', now()),
(18, 'default', 1, 'Customer Account Pages', now())
;

--
-- DDL for table `pages_layouts`
--
DROP TABLE IF EXISTS `ac_pages_layouts`;
CREATE TABLE `ac_pages_layouts` (
  `layout_id` int(10) NOT NULL,
  `page_id` int(10) NOT NULL,
  PRIMARY KEY  (`layout_id`,`page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_pages_layouts` (`layout_id`, `page_id`) VALUES
(1, 1 ),
(2, 2 ),
(5, 4 ),
(6, 5 ),
(7, 3 ),
(11, 1),
(12, 2),
(13, 4),
(14, 5),
(15, 3),
(17, 10),
(18, 11)
;

--
-- DDL for table `block_layouts`
--
DROP TABLE IF EXISTS `ac_block_layouts`;
CREATE TABLE `ac_block_layouts` (
  `instance_id` int(10) NOT NULL auto_increment,
  `layout_id` int(10) NOT NULL default '0',  
  `block_id` int(10) NOT NULL default '0',
  `custom_block_id` int(10) NOT NULL default '0',  
  `parent_instance_id` int(10) NOT NULL default '0', -- 0 for main level block 
  `position` smallint(5) NOT NULL default '0',
  `status` smallint(1) NOT NULL default '0',
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (`instance_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
CREATE UNIQUE INDEX `ac_block_layouts_idx`
ON `ac_block_layouts` ( `instance_id`, `layout_id`, `block_id`, `parent_instance_id`,`custom_block_id` );

INSERT INTO `ac_block_layouts` (`instance_id`, `layout_id`, `block_id`, `custom_block_id`, `parent_instance_id`, `position`, `status`, `date_added`) VALUES
(1, 1, 1, 0, 0, 10, 1, now() ),
(2, 1, 2, 0, 0, 20, 1, now() ),
(3, 1, 3, 0, 0, 30, 1, now() ),
(4, 1, 4, 0, 0, 40, 1, now() ),
(5, 1, 5, 0, 0, 50, 1, now() ),
(6, 1, 6, 0, 0, 60, 1, now() ),
(7, 1, 7, 0, 0, 70, 1, now() ),
(8, 1, 8, 0, 0, 80, 1, now() ),
(9, 1, 9, 0, 3, 10, 1, now() ),
(10, 1, 10, 0, 3, 20, 1, now() ),
(11, 1, 11, 0, 3, 30, 1, now() ),
(12, 1, 9, 0, 6, 30, 1, now() ),
(13, 1, 10, 0, 6, 10, 1, now() ),
(14, 1, 11, 0, 6, 20, 1, now() ),
(35, 1, 13, 0, 1, 10, 1, now() ),
(36, 1, 14, 0, 1, 20, 1, now() ),
(37, 1, 15, 0, 1, 30, 1, now() ),
(38, 1, 21, 0, 8, 10, 1, now() ),
(172, 1, 24, 0, 8, 20, 1, now() );

-- Home page
INSERT INTO `ac_block_layouts` (`instance_id`, `layout_id`, `block_id`, `custom_block_id`, `parent_instance_id`, `position`, `status`, `date_added`) VALUES
(16, 2, 1, 0, 0, 10, 1, now() ),
(17, 2, 2, 0, 0, 20, 1, now() ),
(18, 2, 3, 0, 0, 30, 1, now() ),
(19, 2, 4, 0, 0, 40, 1, now() ),
(20, 2, 5, 0, 0, 50, 1, now() ),
(21, 2, 6, 0, 0, 60, 1, now() ),
(22, 2, 7, 0, 0, 70, 1, now() ),
(23, 2, 8, 0, 0, 80, 1, now() ),
(24, 2, 9, 0, 18, 10, 1, now() ),
(25, 2, 10, 0, 18, 20, 1, now() ),
(26, 2, 11, 0, 18, 30, 1, now() ),
(27, 2, 12, 0, 20, 10, 1, now() ),
(28, 2, 18, 0, 21, 10, 1, now() ),
(29, 2, 19, 0, 21, 20, 1, now() ),
(31, 2, 15, 0, 16, 30, 1, now() ),
(32, 2, 13, 0, 16, 10, 1, now() ),
(33, 2, 14, 0, 16, 20, 1, now() ),
(34, 2, 17, 1, 19, 10, 1, now() ),
(39, 2, 21, 0, 23, 10, 1, now() ),
(40, 2, 24, 0, 23, 20, 1, now() );

-- Login page
INSERT INTO `ac_block_layouts` (`instance_id`, `layout_id`, `block_id`, `custom_block_id`, `parent_instance_id`, `position`, `status`, `date_added`) VALUES
(56, 5, 13, 0, 55, 10, 1, now() ),
(64, 5, 7, 0, 0, 70, 1, now() ),
(63, 5, 6, 0, 0, 60, 0, now() ),
(62, 5, 5, 0, 0, 50, 1, now() ),
(61, 5, 4, 0, 0, 40, 1, now() ),
(60, 5, 3, 0, 0, 30, 0, now() ),
(59, 5, 2, 0, 0, 20, 1, now() ),
(58, 5, 15, 0, 55, 30, 1, now() ),
(57, 5, 14, 0, 55, 20, 1, now() ),
(55, 5, 1, 0, 0, 10, 1, now() ),
(65, 5, 8, 0, 0, 80, 1, now() ),
(98, 5, 21, 0, 65, 10, 1, now() ),
(99, 5, 24, 0, 65, 20, 1, now() );
-- Default Product page
INSERT INTO `ac_block_layouts` (`instance_id`, `layout_id`, `block_id`, `custom_block_id`, `parent_instance_id`, `position`, `status`, `date_added`) VALUES
(66, 6, 13, 0, 75, 10, 1, now() ),
(67, 6, 7, 0, 0, 70, 1, now() ),
(68, 6, 6, 0, 0, 60, 0, now() ),
(69, 6, 5, 0, 0, 50, 1, now() ),
(70, 6, 4, 0, 0, 40, 1, now() ),
(71, 6, 3, 0, 0, 30, 0, now() ),
(72, 6, 2, 0, 0, 20, 1, now() ),
(73, 6, 15, 0, 75, 30, 1, now() ),
(74, 6, 14, 0, 75, 20, 1, now() ),
(75, 6, 1, 0, 0, 10, 1, now() ),
(76, 6, 8, 0, 0, 80, 1, now() ),
(95, 6, 21, 0, 76, 10, 1, now() ),
(170, 6, 24, 0, 76, 20, 1, now() );
-- Checkout pages
INSERT INTO `ac_block_layouts` (`instance_id`, `layout_id`, `block_id`, `custom_block_id`, `parent_instance_id`, `position`, `status`, `date_added`) VALUES
(77, 7, 1, 0, 0, 10, 1, now() ),
(78, 7, 7, 0, 0, 70, 1, now() ),
(79, 7, 6, 0, 0, 60, 1, now() ),
(80, 7, 5, 0, 0, 50, 1, now() ),
(81, 7, 2, 0, 0, 20, 1, now() ),
(82, 7, 3, 0, 0, 30, 0, now() ),
(83, 7, 4, 0, 0, 40, 1, now() ),
(87, 7, 8, 0, 0, 80, 1, now() ),
(91, 7, 13, 0, 77, 10, 1, now() ),
(92, 7, 14, 0, 77, 20, 1, now() ),
(93, 7, 15, 0, 77, 30, 1, now() ),
(94, 7, 16, 0, 79, 10, 1, now() ),
(96, 7, 21, 0, 87, 10, 1, now() ),
(171, 7, 24, 0, 87, 20, 1, now() );


-- DEFAULT template's layouts
INSERT INTO `ac_block_layouts` (`instance_id`,`layout_id`,`block_id`,`custom_block_id`,`parent_instance_id`,`position`,`status`,`date_added`,`date_modified`) VALUES
(1839,	11,	25,	0,	337,	40,	1,	NOW(),	NOW()),	
(338,	11,	9,	0,	3,		10,	1,	NOW(),	NOW()),	
(337,	11,	8,	0,	0,		80,	1,	NOW(),	NOW()),	
(336,	11,	7,	0,	0,		70,	1,	NOW(),	NOW()),	
(335,	11,	6,	0,	0,		60,	1,	NOW(),	NOW()),	
(334,	11,	5,	0,	0,		50,	1,	NOW(),	NOW()),	
(333,	11,	4,	0,	0,		40,	1,	NOW(),	NOW()),	
(332,	11,	3,	0,	0,		30,	1,	NOW(),	NOW()),	
(331,	11,	2,	0,	0,		20,	1,	NOW(),	NOW()),	
(1836,	11,	17,	13,	337,	10,	1,	NOW(),	NOW()),	
(339,	11,	10,	0,	3,		20,	1,	NOW(),	NOW()),	
(340,	11,	11,	0,	3,		30,	1,	NOW(),	NOW()),	
(341,	11,	9,	0,	6,		30,	1,	NOW(),	NOW()),	
(1841,	11,	17,	15,	337,	60,	1,	NOW(),	NOW()),	
(1840,	11,	11,	0,	337,	50,	1,	NOW(),	NOW()),	
(1838,	11,	17,	16,	337,	30,	1,	NOW(),	NOW()),	
(1837,	11,	17,	14,	337,	20,	1,	NOW(),	NOW()),	
(348,	11,	24,	0,	8,		20,	1,	NOW(),	NOW()),	
(347,	11,	21,	0,	8,		10,	1,	NOW(),	NOW()),	
(346,	11,	15,	0,	1,		30,	1,	NOW(),	NOW()),	
(345,	11,	14,	0,	1,		20,	1,	NOW(),	NOW()),	
(344,	11,	13,	0,	1,		10,	1,	NOW(),	NOW()),	
(343,	11,	11,	0,	6,		20,	1,	NOW(),	NOW()),	
(342,	11,	10,	0,	6,		10,	1,	NOW(),	NOW()),	
(330,	11,	1,	0,	0,		10,	1,	NOW(),	NOW()),	
(1835,	11,	9,	0,	331,	10,	1,	NOW(),	NOW()),	
(1842,	11,	24,	0,	337,	70,	1,	NOW(),	NOW()),	
(1843,	11,	21,	0,	337,	80,	1,	NOW(),	NOW()),	
(1844,	11,	31,	0,	330,	20,	1,	NOW(),	NOW()),	
(1829,	11,	27,	0,	330,	30,	1,	NOW(),	NOW()),	
(1830,	11,	26,	0,	330,	40,	1,	NOW(),	NOW()),	
(1831,	11,	14,	0,	330,	60,	1,	NOW(),	NOW()),
(1832,	11,	13,	0,	330,	50,	1,	NOW(),	NOW()),
(1833,	11,	15,	0,	330,	70,	1,	NOW(),	NOW()),	
(1834,	11,	17,	15,	330,	80,	1,	NOW(),	NOW()),	
(1782,	12,	21,	0,	356,	80,	1,	NOW(),	NOW()),	
(354,	12,	6,	0,	0,		60,	0,	NOW(),	NOW()),	
(352,	12,	4,	0,	0,		40,	1,	NOW(),	NOW()),	
(351,	12,	3,	0,	0,		30,	0,	NOW(),	NOW()),	
(350,	12,	2,	0,	0,		20,	1,	NOW(),	NOW()),	
(353,	12,	5,	0,	0,		50,	1,	NOW(),	NOW()),	
(1780,	12,	17,	15,	356,	60,	1,	NOW(),	NOW()),	
(1781,	12,	24,	0,	356,	70,	1,	NOW(),	NOW()),	
(355,	12,	7,	0,	0,		70,	1,	NOW(),	NOW()),	
(356,	12,	8,	0,	0,		80,	1,	NOW(),	NOW()),	
(368,	12,	24,	0,	23,		20,	1,	NOW(),	NOW()),	
(367,	12,	21,	0,	23,		10,	1,	NOW(),	NOW()),	
(366,	12,	17,	1,	19,		10,	1,	NOW(),	NOW()),	
(365,	12,	14,	0,	16,		20,	1,	NOW(),	NOW()),	
(364,	12,	13,	0,	16,		10,	1,	NOW(),	NOW()),	
(363,	12,	15,	0,	16,		30,	1,	NOW(),	NOW()),	
(362,	12,	19,	0,	21,		20,	1,	NOW(),	NOW()),	
(361,	12,	18,	0,	21,		10,	1,	NOW(),	NOW()),	
(360,	12,	12,	0,	20,		10,	1,	NOW(),	NOW()),	
(359,	12,	11,	0,	18,		30,	1,	NOW(),	NOW()),	
(358,	12,	10,	0,	18,		20,	1,	NOW(),	NOW()),	
(357,	12,	9,	0,	18,		10,	1,	NOW(),	NOW()),	
(349,	12,	1,	0,	0,		10,	1,	NOW(),	NOW()),	
(1774,	12,	20,	12,	353,	60,	1,	NOW(),	NOW()),	
(1775,	12,	17,	13,	356,	10,	1,	NOW(),	NOW()),	
(1763,	12,	14,	0,	349,	60,	1,	NOW(),	NOW()),	
(1764,	12,	15,	0,	349,	70,	1,	NOW(),	NOW()),	
(1765,	12,	17,	15,	349,	80,	1,	NOW(),	NOW()),	
(1761,	12,	26,	0,	349,	40,	1,	NOW(),	NOW()),	
(1776,	12,	17,	14,	356,	20,	1,	NOW(),	NOW()),	
(1767,	12,	23,	9,	350,	20,	1,	NOW(),	NOW()),	
(1768,	12,	17,	10,	352,	10,	1,	NOW(),	NOW()),	
(1762,	12,	13,	0,	349,	50,	1,	NOW(),	NOW()),	
(1770,	12,	12,	0,	353,	20,	1,	NOW(),	NOW()),	
(1771,	12,	18,	0,	353,	30,	1,	NOW(),	NOW()),	
(1772,	12,	22,	0,	353,	40,	1,	NOW(),	NOW()),	
(1773,	12,	23,	11,	353,	50,	1,	NOW(),	NOW()),	
(1766,	12,	9,	0,	350,	10,	1,	NOW(),	NOW()),	
(1779,	12,	11,	0,	356,	50,	1,	NOW(),	NOW()),	
(1777,	12,	17,	16,	356,	30,	1,	NOW(),	NOW()),	
(1769,	12,	19,	0,	353,	10,	1,	NOW(),	NOW()),	
(1778,	12,	25,	0,	356,	40,	1,	NOW(),	NOW()),	
(1845,	12,	31,	0,	349,	20,	1,	NOW(),	NOW()),	
(1760,	12,	27,	0,	349,	30,	1,	NOW(),	NOW()),	
(1846,	13,	31,	0,	378,	20,	1,	NOW(),	NOW()),	
(1799,	13,	27,	0,	378,	30,	1,	NOW(),	NOW()),	
(1810,	13,	11,	0,	379,	50,	1,	NOW(),	NOW()),	
(1805,	13,	9,	0,	375,	10,	1,	NOW(),	NOW()),	
(1801,	13,	13,	0,	378,	50,	1,	NOW(),	NOW()),	
(1813,	13,	21,	0,	379,	80,	1,	NOW(),	NOW()),	
(1809,	13,	25,	0,	379,	40,	1,	NOW(),	NOW()),	
(1808,	13,	17,	16,	379,	30,	1,	NOW(),	NOW()),	
(1811,	13,	17,	15,	379,	60,	1,	NOW(),	NOW()),	
(1807,	13,	17,	14,	379,	20,	1,	NOW(),	NOW()),	
(1806,	13,	17,	13,	379,	10,	1,	NOW(),	NOW()),	
(1800,	13,	26,	0,	378,	40,	1,	NOW(),	NOW()),	
(1812,	13,	24,	0,	379,	70,	1,	NOW(),	NOW()),	
(369,	13,	13,	0,	55,		10,	1,	NOW(),	NOW()),	
(1802,	13,	14,	0,	378,	60,	1,	NOW(),	NOW()),	
(1803,	13,	15,	0,	378,	70,	1,	NOW(),	NOW()),	
(1804,	13,	17,	15,	378,	80,	1,	NOW(),	NOW()),	
(381,	13,	24,	0,	65,		20,	1,	NOW(),	NOW()),	
(380,	13,	21,	0,	65,		10,	1,	NOW(),	NOW()),	
(379,	13,	8,	0,	0,		80,	1,	NOW(),	NOW()),	
(378,	13,	1,	0,	0,		10,	1,	NOW(),	NOW()),	
(377,	13,	14,	0,	55,		20,	1,	NOW(),	NOW()),	
(376,	13,	15,	0,	55,		30,	1,	NOW(),	NOW()),	
(370,	13,	7,	0,	0,		70,	1,	NOW(),	NOW()),	
(371,	13,	6,	0,	0,		60,	0,	NOW(),	NOW()),	
(372,	13,	5,	0,	0,		50,	1,	NOW(),	NOW()),	
(373,	13,	4,	0,	0,		40,	1,	NOW(),	NOW()),	
(374,	13,	3,	0,	0,		30,	0,	NOW(),	NOW()),	
(375,	13,	2,	0,	0,		20,	1,	NOW(),	NOW()),	
(1795,	14,	11,	0,	392,	50,	1,	NOW(),	NOW()),	
(1794,	14,	25,	0,	392,	40,	1,	NOW(),	NOW()),	
(1793,	14,	17,	16,	392,	30,	1,	NOW(),	NOW()),	
(1790,	14,	12,	0,	387,	10,	1,	NOW(),	NOW()),	
(1792,	14,	17,	14,	392,	20,	1,	NOW(),	NOW()),	
(1796,	14,	17,	15,	392,	60,	1,	NOW(),	NOW()),	
(1847,	14,	31,	0,	391,	20,	1,	NOW(),	NOW()),	
(1783,	14,	27,	0,	391,	30,	1,	NOW(),	NOW()),	
(1784,	14,	26,	0,	391,	40,	1,	NOW(),	NOW()),	
(1791,	14,	17,	13,	392,	10,	1,	NOW(),	NOW()),	
(1785,	14,	13,	0,	391,	50,	1,	NOW(),	NOW()),	
(1786,	14,	14,	0,	391,	60,	1,	NOW(),	NOW()),	
(1789,	14,	9,	0,	388,	10,	1,	NOW(),	NOW()),	
(1788,	14,	17,	15,	391,	80,	1,	NOW(),	NOW()),	
(1787,	14,	15,	0,	391,	70,	1,	NOW(),	NOW()),	
(1797,	14,	24,	0,	392,	70,	1,	NOW(),	NOW()),	
(1798,	14,	21,	0,	392,	80,	1,	NOW(),	NOW()),	
(388,	14,	2,	0,	0,		20,	1,	NOW(),	NOW()),	
(386,	14,	4,	0,	0,		40,	1,	NOW(),	NOW()),	
(387,	14,	3,	0,	0,		30,	1,	NOW(),	NOW()),	
(384,	14,	6,	0,	0,		60,	0,	NOW(),	NOW()),	
(383,	14,	7,	0,	0,		70,	1,	NOW(),	NOW()),	
(389,	14,	15,	0,	75,		30,	1,	NOW(),	NOW()),	
(390,	14,	14,	0,	75,		20,	1,	NOW(),	NOW()),	
(382,	14,	13,	0,	75,		10,	1,	NOW(),	NOW()),	
(391,	14,	1,	0,	0,		10,	1,	NOW(),	NOW()),	
(392,	14,	8,	0,	0,		80,	1,	NOW(),	NOW()),	
(393,	14,	21,	0,	76,		10,	1,	NOW(),	NOW()),	
(394,	14,	24,	0,	76,		20,	1,	NOW(),	NOW()),	
(385,	14,	5,	0,	0,		50,	1,	NOW(),	NOW()),	
(1827,	15,	24,	0,	403,	70,	1,	NOW(),	NOW()),	
(1818,	15,	15,	0,	395,	70,	1,	NOW(),	NOW()),	
(1817,	15,	14,	0,	395,	60,	1,	NOW(),	NOW()),	
(1816,	15,	13,	0,	395,	50,	1,	NOW(),	NOW()),	
(1828,	15,	21,	0,	403,	80,	1,	NOW(),	NOW()),	
(1815,	15,	26,	0,	395,	40,	1,	NOW(),	NOW()),	
(1848,	15,	31,	0,	395,	20,	1,	NOW(),	NOW()),	
(1814,	15,	27,	0,	395,	30,	1,	NOW(),	NOW()),	
(1820,	15,	9,	0,	399,	10,	1,	NOW(),	NOW()),	
(1819,	15,	17,	15,	395,	80,	1,	NOW(),	NOW()),	
(1822,	15,	17,	14,	403,	20,	1,	NOW(),	NOW()),	
(1825,	15,	11,	0,	403,	50,	1,	NOW(),	NOW()),	
(402,	15,	5,	0,	0,		50,	1,	NOW(),	NOW()),	
(401,	15,	4,	0,	0,		40,	1,	NOW(),	NOW()),	
(400,	15,	3,	0,	0,		30,	0,	NOW(),	NOW()),	
(399,	15,	2,	0,	0,		20,	1,	NOW(),	NOW()),	
(398,	15,	5,	0,	0,		50,	1,	NOW(),	NOW()),	
(397,	15,	6,	0,	0,		60,	1,	NOW(),	NOW()),	
(396,	15,	7,	0,	0,		70,	1,	NOW(),	NOW()),	
(1821,	15,	17,	13,	403,	10,	1,	NOW(),	NOW()),	
(395,	15,	1,	0,	0,		10,	1,	NOW(),	NOW()),	
(1824,	15,	25,	0,	403,	40,	1,	NOW(),	NOW()),	
(1823,	15,	17,	16,	403,	30,	1,	NOW(),	NOW()),	
(403,	15,	8,	0,	0,		80,	1,	NOW(),	NOW()),	
(404,	15,	13,	0,	77,		10,	1,	NOW(),	NOW()),	
(405,	15,	14,	0,	77,		20,	1,	NOW(),	NOW()),	
(406,	15,	15,	0,	77,		30,	1,	NOW(),	NOW()),	
(409,	15,	24,	0,	87,		20,	1,	NOW(),	NOW()),	
(1826,	15,	17,	15,	403,	60,	1,	NOW(),	NOW()),	
(408,	15,	21,	0,	87,		10,	1,	NOW(),	NOW()),	
(407,	15,	16,	0,	79,		10,	1,	NOW(),	NOW()),	
(942,	17,	5,	0,	0,		50,	1,	NOW(),	NOW()),	
(943,	17,	6,	0,	0,		60,	1,	NOW(),	NOW()),	
(944,	17,	7,	0,	0,		70,	1,	NOW(),	NOW()),	
(945,	17,	8,	0,	0,		80,	1,	NOW(),	NOW()),	
(940,	17,	3,	0,	0,		30,	1,	NOW(),	NOW()),	
(939,	17,	2,	0,	0,		20,	1,	NOW(),	NOW()),	
(938,	17,	1,	0,	0,		10,	1,	NOW(),	NOW()),	
(941,	17,	4,	0,	0,		40,	1,	NOW(),	NOW());

-- DEFAULT template's layouts
INSERT INTO `ac_block_layouts` (`instance_id`,	 `layout_id`,	 `block_id`,	 `custom_block_id`,	 `parent_instance_id`,	 `position`,	 `status`,	 `date_added`,	`date_modified`) VALUES
(1900,	18,	5,	0,	0,		50,	1,	NOW(),	NOW()),	
(1901,	18,	4,	0,	0,		40,	1,	NOW(),	NOW()),	
(1902,	18,	3,	0,	0,		30,	0,	NOW(),	NOW()),	
(1903,	18,	2,	0,	0,		20,	1,	NOW(),	NOW()),	
(1904,	18,	5,	0,	0,		50,	1,	NOW(),	NOW()),	
(1905,	18,	6,	0,	0,		60,	1,	NOW(),	NOW()),	
(1906,	18,	7,	0,	0,		70,	1,	NOW(),	NOW()),	
(1907,	18,	1,	0,	0,		10,	1,	NOW(),	NOW()),	
(1908,	18,	8,	0,	0,		80,	1,	NOW(),	NOW()),	
(1909,	18,	13,	0,	77,		10,	1,	NOW(),	NOW()),	
(1910,	18,	14,	0,	77,		20,	1,	NOW(),	NOW()),	
(1911,	18,	15,	0,	77,		30,	1,	NOW(),	NOW()),	
(1912,	18,	24,	0,	87,		20,	1,	NOW(),	NOW()),	
(1913,	18,	21,	0,	87,		10,	1,	NOW(),	NOW()),	
(1914,	18,	16,	0,	79,		10,	1,	NOW(),	NOW()),	
(1920,	18,	24,	0,	1908,	70,	1,	NOW(),	NOW()),	
(1921,	18,	15,	0,	1907,	70,	1,	NOW(),	NOW()),	
(1922,	18,	14,	0,	1907,	60,	1,	NOW(),	NOW()),	
(1923,	18,	13,	0,	1907,	50,	1,	NOW(),	NOW()),	
(1924,	18,	21,	0,	1908,	80,	1,	NOW(),	NOW()),	
(1925,	18,	26,	0,	1907,	40,	1,	NOW(),	NOW()),	
(1849,	18,	31,	0,	1907,	20,	1,	NOW(),	NOW()),	
(1926,	18,	27,	0,	1907,	30,	1,	NOW(),	NOW()),	
(1927,	18,	9,	0,	1903,	10,	1,	NOW(),	NOW()),	
(1928,	18,	17,	15,	1907,	80,	1,	NOW(),	NOW()),	
(1929,	18,	17,	14,	1908,	20,	1,	NOW(),	NOW()),	
(1930,	18,	11,	0,	1908,	50,	1,	NOW(),	NOW()),	
(1931,	18,	17,	13,	1908,	10,	1,	NOW(),	NOW()),	
(1932,	18,	25,	0,	1908,	40,	1,	NOW(),	NOW()),	
(1933,	18,	17,	16,	1908,	30,	1,	NOW(),	NOW()),	
(1934,	18,	17,	15,	1908,	60,	1,	NOW(),	NOW()),	
(1935,	18,	29,	0,	1905,	10,	1,	NOW(),	NOW());

-- add breadcrumbs 
INSERT INTO `ac_block_layouts` (`instance_id`,	 `layout_id`,	 `block_id`,	 `custom_block_id`,	 `parent_instance_id`,	 `position`,	 `status`,	 `date_added`,	`date_modified`) VALUES
(1950,	11,	28,	0,	331,	20,	1,	NOW(),	NOW()),	
(1951,	13,	28,	0,	375,	20,	1,	NOW(),	NOW()),	
(1952,	14,	28,	0,	388,	20,	1,	NOW(),	NOW()),	
(1953,	15,	28,	0,	399,	20,	1,	NOW(),	NOW()),	
(1954,	17,	28,	0,	939,	20,	1,	NOW(),	NOW()),	
(1955,	18,	28,	0,	1903,	20,	1,	NOW(),	NOW());


--
-- DDL for table `forms_pages`
--
DROP TABLE IF EXISTS `ac_pages_forms`;
CREATE TABLE `ac_pages_forms` (
  `page_id` int(10) NOT NULL,
  `form_id` int(10) NOT NULL,
  PRIMARY KEY  (`form_id`,`page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `forms`
--
DROP TABLE IF EXISTS `ac_forms`;
CREATE TABLE `ac_forms` (
  `form_id` int(11) NOT NULL auto_increment,
  `form_name` varchar(40) NOT NULL default '',
  -- used to create css ID and name for form tag
  `controller` varchar(100) NOT NULL default '',
  `success_page` varchar(100) NOT NULL default '',
  `status` smallint(1) NOT NULL default '0',
  PRIMARY KEY  (`form_id`),
  UNIQUE KEY `form_name` (`form_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

INSERT INTO `ac_forms` VALUES (2,'ContactUsFrm','content/contact','content/contact/success',1);

--
-- DDL for table `form_descriptions`
--
DROP TABLE IF EXISTS `ac_form_descriptions`;
CREATE TABLE `ac_form_descriptions` (
  `form_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  PRIMARY KEY (`form_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_form_descriptions` VALUES (2,1,'Contact Us Form');

--
-- DDL for table `fields`
--
DROP TABLE IF EXISTS `ac_fields`;
CREATE TABLE `ac_fields` (
  `field_id` int(11) NOT NULL NULL auto_increment,
  `form_id` int(11) NOT NULL DEFAULT '0',
  `field_name` varchar(40) NOT NULL, 
  -- used to create css ID (form_name + field_name) and name for input tag tag
  `element_type` char(1) NOT NULL DEFAULT 'I',
  -- I - text input, T - Text area, S - Select, M - multivalue select, C - Checkbox, R - radio buttons, U - File upload, H - Hidden, G -Checkbox Group, D - Date, E - time, K - Captcha 
  `sort_order` int(3) NOT NULL,
  `attributes` varchar(255) NOT NULL,
  `settings` text COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `required` char(1) NOT NULL DEFAULT 'N',
  -- N - Not required, Y - required  
  `status` smallint(1) NOT NULL default '0',
  `regexp_pattern` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`),
  KEY `field_id` (`field_id`, `form_id`, `status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_fields`
(field_id, form_id, field_name, element_type, sort_order, attributes,settings, required, regexp_pattern, status)
VALUES
(11,2,'first_name','I',1,'','','Y','/^.{3,100}$/u',1),
(12,2,'email','I',2,'','','Y','/^[A-Z0-9._%-]+@[A-Z0-9][A-Z0-9.-]{0,61}[A-Z0-9]\.[A-Z]{2,6}$/i',1),
(13,2,'enquiry','T',3,'cols="50" rows="8"','','Y','/^.{3,1000}$/su',1),
(14,2,'captcha','K',4,'','','Y','',1);

--
-- DDL for table `field_descriptions`
--
DROP TABLE IF EXISTS `ac_field_descriptions`;
CREATE TABLE `ac_field_descriptions` (
  `field_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL COMMENT 'translatable',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  `language_id` int(11) NOT NULL,
  `error_text` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  PRIMARY KEY (`field_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_field_descriptions` (`field_id`, `name`, `error_text`, `language_id`)
VALUES
(11,'نام:','نام باید بین 3 تا 32 کاراکتر باشد!',1),
(12,'ایمیل:','آدرس ایمیل بنظر نمی رسد به معتبر باشد.',1),
(13,'پرس و جو:','پرس و جو باید بین 10 و 3000 کاراکتر باشد.',1),
(14,'کد امنیتی را در کادر زیر وارد کنید:','کد امنیتی باتصویر مطابقت ندارد!',1);

--
-- DDL for table `ac_field_values`
--
DROP TABLE IF EXISTS `ac_field_values`;
CREATE TABLE `ac_field_values` (
  `value_id` int(11) NOT NULL auto_increment,
  `field_id` int(11) NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'translatable',
  `language_id` int(11) NOT NULL,
  PRIMARY KEY (`value_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- DDL for table `fields_groups`
--
DROP TABLE IF EXISTS `ac_form_groups`;
CREATE TABLE `ac_form_groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(40) NOT NULL default '',
  `form_id` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(3) NOT NULL,
  `status` smallint(1) NOT NULL default '0',
  PRIMARY KEY (`group_id`),
  KEY `group_id` (`group_id`, `form_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- DDL for table `fields_groups`
--
DROP TABLE IF EXISTS `ac_fields_groups`;
CREATE TABLE `ac_fields_groups` (
  `field_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `sort_order` int(3) NOT NULL,
  PRIMARY KEY (`field_id`),
  KEY `field_id` (`field_id`, `group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- DDL for table `fields_group_descriptions`
--
DROP TABLE IF EXISTS `ac_fields_group_descriptions`;
CREATE TABLE `ac_fields_group_descriptions` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL COMMENT 'translatable',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  `language_id` int(11) NOT NULL,
  PRIMARY KEY (`group_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `ac_messages`
--
DROP TABLE IF EXISTS `ac_messages`;
CREATE TABLE `ac_messages` (
  `msg_id` int(11) NOT NULL auto_increment,
  `title` varchar(128) NOT NULL default '',
  `message` text NOT NULL,
  `status` char(1) NOT NULL default '',
  `viewed` int(11) NOT NULL default '0',
  `repeated` int(11) NOT NULL default '0',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY  (`msg_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- DDL for table `ac_ant_messages`
--
DROP TABLE IF EXISTS `ac_ant_messages`;
CREATE TABLE `ac_ant_messages` (
  `id` varchar(60) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 0,
  `start_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `end_date` timestamp,
  `viewed_date` timestamp,
  `viewed` int(11) NOT NULL default '0',
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `html` text,
  `url` text,
  `language_code` varchar(2) NOT NULL DEFAULT 'en',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `language_code`),
  KEY `daterange_idx` (`start_date`,`end_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


--
-- DDL for table `ac_datasets`
--
DROP TABLE IF EXISTS `ac_datasets`;
CREATE TABLE `ac_datasets` (
  `dataset_id` int(11) NOT NULL AUTO_INCREMENT,
  `dataset_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `dataset_key` varchar(255) CHARACTER SET utf8 default '',
  PRIMARY KEY (`dataset_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;


--
-- DDL for table `ac_dataset_properties`
--
DROP TABLE IF EXISTS `ac_dataset_properties`;
CREATE TABLE `ac_dataset_properties` (
	`rowid` int(11) NOT NULL AUTO_INCREMENT,
  `dataset_id` int(11) NOT NULL,
  `dataset_property_name` varchar(255) NOT NULL,
  `dataset_property_value` varchar(255),
	PRIMARY KEY (`rowid`),
  KEY `dataset_property_idx` (`dataset_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci  AUTO_INCREMENT=1;

--
-- DDL for table `ac_dataset_definition`
--
DROP TABLE IF EXISTS `ac_dataset_definition`;
CREATE TABLE `ac_dataset_definition` (
  `dataset_id` int(11) NOT NULL,
  `dataset_column_id` int(11) NOT NULL AUTO_INCREMENT,
  `dataset_column_name` varchar(255) NOT NULL,
  `dataset_column_type` varchar(100) NOT NULL,
  `dataset_column_sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dataset_column_id`),
  KEY `dataset_definition_idx` (`dataset_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- DDL for table `ac_dataset_column_properties`
--
DROP TABLE IF EXISTS `ac_dataset_column_properties`;
CREATE TABLE `ac_dataset_column_properties` (
	`rowid` INT(11) NOT NULL AUTO_INCREMENT,
  `dataset_column_id` int(11) NOT NULL,
  `dataset_column_property_name` varchar(255) NOT NULL,
  `dataset_column_property_value` varchar(255) DEFAULT NULL,
	PRIMARY KEY (`rowid`),
  KEY `dataset_column_properties_idx` (`dataset_column_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci  AUTO_INCREMENT=1;

--
-- DDL for table `ac_dataset_values`
--
DROP TABLE IF EXISTS `ac_dataset_values`;
CREATE TABLE `ac_dataset_values` (
  `dataset_column_id` int(11) NOT NULL,
  `value_integer` int(11) DEFAULT NULL,
  `value_float` float DEFAULT NULL,
  `value_varchar` varchar(255) DEFAULT NULL,
  `value_text` text,
  `value_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `value_boolean` tinyint(1) DEFAULT NULL,
  `value_sort_order` int(11) NOT NULL AUTO_INCREMENT,
  `row_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`value_sort_order`),
  KEY `dataset_values_idx` (`value_integer`,`value_float`,`value_varchar`,`value_boolean`,`row_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
--
-- Storefront menu inserts
--
INSERT INTO `ac_datasets` (`dataset_name`,`dataset_key`) VALUES ('menu','storefront');
INSERT INTO `ac_dataset_properties` (`dataset_id`,`dataset_property_name`,`dataset_property_value`) VALUES ('1','controller','design/menu');


INSERT INTO `ac_dataset_definition` (`dataset_id`,`dataset_column_name`,`dataset_column_type`,`dataset_column_sort_order`)
VALUES  (1,'item_id','varchar',1),
        (1,'item_icon','varchar',2),
        (1,'item_url','varchar',3),
        (1,'parent_id','varchar',4),
        (1,'sort_order','integer',5),
        (1,'item_type','varchar',6),
        (1,'item_icon_rl_id','integer',7);
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (1,'home',1),
        (1,'login',2),
        (1,'logout',3),
        (1,'account',4),
        (1,'cart',5),
        (1,'checkout',6),
        (1,'specials',7);

-- ITEM_ICON
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (2,'',1),
        (2,'',2),
        (2,'',3),
        (2,'',4),
        (2,'',5),
        (2,'',6),
        (2,'',7);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (3,'index/home',1),
        (3,'account/login',2),
        (3,'account/logout',3),
        (3,'account/account',4),
        (3,'checkout/cart',5),
        (3,'checkout/shipping',6),
        (3,'product/special',7);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (4,'',1),
        (4,'account',2),
        (4,'account',3),
        (4,'',4),
        (4,'',5),
        (4,'',6),
        (4,'',7);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`)
VALUES  (5,10,1),
        (5,20,2),
        (5,30,3),
        (5,40,4),
        (5,50,5),
        (5,60,6),
        (5,11,7);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (6,'core',1),
        (6,'core',2),
        (6,'core',3),
        (6,'core',4),
        (6,'core',5),
        (6,'core',6),
        (6,'core',7);
-- item_icon_rl_id
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`)
VALUES  (7,'2',1),
        (7,'4',2),
        (7,'3',3),
        (7,'4',4),
        (7,'250',5),
       	(7,'260',6),
       	(7,'244',7);

--
-- ADMIN MENU SECTION
--
INSERT INTO `ac_datasets` (`dataset_name`,`dataset_key`) VALUES ('menu','admin');
INSERT INTO `ac_dataset_definition` (`dataset_id`,`dataset_column_id`,`dataset_column_name`,`dataset_column_type`,`dataset_column_sort_order`)
VALUES  (2,10, 'item_id','varchar',1),
        (2,11, 'item_text','varchar',2),
        (2,12, 'item_url','varchar',3),
        (2,13, 'parent_id','varchar',4),
        (2,14, 'sort_order','integer',5),
        (2,15, 'item_type','varchar',6),
        (2,40, 'item_icon_rl_id','varchar',7);
--		
-- MAIN (PARENT) MENU
--
--		
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (10,'catalog',1),
        (10,'sale',2),
        (10,'design',3),
        (10,'extension',4),
        (10,'system',5),
        (10,'reports',6),
        (10,'help',7);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (11,'text_catalog',1),
        (11,'text_sale',2),
        (11,'text_design',3),
        (11,'text_extension',4),
        (11,'text_system',5),
        (11,'text_reports',6),
        (11,'text_help',7);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (12,'catalog/category',1),
        (12,'sale/order',2),
        (12,'extension/extensions/template',3),
        (12,'extension/extensions/extensions',4),
        (12,'setting/setting',5),
        (12,'report/sale/orders',6),
        (12,'',7);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (13,'',1),
        (13,'',2),
        (13,'',3),
        (13,'',4),
        (13,'',5),
        (13,'',6),
        (13,'',7);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES  (14,1,1),
        (14,2,2),
        (14,3,3),
        (14,4,4),
        (14,5,5),
        (14,6,6),
        (14,7,7);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (15,'core',1),
        (15,'core',2),
        (15,'core',3),
        (15,'core',4),
        (15,'core',5),
        (15,'core',6),
        (15,'core',7);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'200',1),
        (40,'201',2),
        (40,'202',3),
        (40,'203',4),
        (40,'204',5),
        (40,'205',6),
        (40,'206',7);

--		
-- SUBMENU CATEGORY
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (10,'category',11),
        (10,'product',12),
        (10,'manufacturer',13),
        (10,'download',14),
        (10,'review',15),
        (10,'attributes',16);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (11,'text_category',11),
        (11,'text_product',12),
        (11,'text_manufacturer',13),
        (11,'text_download',14),
        (11,'text_review',15),
        (11,'text_attribute',16);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (12,'catalog/category',11),
        (12,'catalog/product',12),
        (12,'catalog/manufacturer',13),
        (12,'catalog/download',14),
        (12,'catalog/review',15),
        (12,'catalog/attribute',16);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (13,'catalog',11),
        (13,'catalog',12),
        (13,'catalog',13),
        (13,'catalog',14),
        (13,'catalog',15),
        (13,'catalog',16);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES  (14,1,11),
        (14,2,12),
        (14,3,13),
        (14,4,14),
        (14,5,15),
        (14,6,16);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (15,'core',11),
        (15,'core',12),
        (15,'core',13),
        (15,'core',14),
        (15,'core',15),
        (15,'core',16);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'207',11),
        (40,'208',12),
        (40,'209',13),
        (40,'210',14),
        (40,'211',15),
        (40,'212',16);

--
-- SUBMENU EXTENSION
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (10,'extensions',31),
        (10,'shipping',32),
        (10,'payment',33),
        (10,'templates',34),
        (10,'languages',35),
        (10,'total',36),
        (10,'add_extension',37),
        (10,'extensions_stores',38);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (11,'text_extensions',31),
        (11,'text_shipping',32),
        (11,'text_payment',33),
        (11,'text_templates',34),
        (11,'text_language',35),
        (11,'text_total',36),
        (11,'text_add_extension',37),
        (11,'text_extensions_store',38);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (12,'extension/extensions/extensions',31),
        (12,'extension/extensions/shipping',32),
        (12,'extension/extensions/payment',33),
        (12,'extension/extensions/template',34),
        (12,'extension/extensions/language',35),
        (12,'extension/total',36),
        (12,'tool/package_installer',37),
        (12,'extension/extensions_store',38);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (13,'extension',31),
        (13,'extension',32),
        (13,'extension',33),
        (13,'extension',34),
        (13,'extension',35),
        (13,'extension',36),
        (13,'extension',37),
        (13,'extension',38);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES  (14,1,31),
        (14,2,32),
        (14,3,33),
        (14,4,34),
        (14,5,35),
        (14,6,36),
        (14,7,37),
        (14,8,38);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (15,'core',31),
        (15,'core',32),
        (15,'core',33),
        (15,'core',34),
        (15,'core',35),
        (15,'core',36);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'213',31),
        (40,'214',32),
        (40,'215',33),
        (40,'216',34),
        (40,'217',35),
        (40,'218',36),
        (40,'219',37),
        (40,'220',38);


--
-- SUBMENU SALE
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (10,'order',51),
        (10,'customer',52),
        (10,'customer_group',53),
        (10,'coupon',54),
        (10,'contact',55);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (11,'text_order',51),
        (11,'text_customer',52),
        (11,'text_customer_group',53),
        (11,'text_coupon',54),
        (11,'text_contact',55);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (12,'sale/order',51),
        (12,'sale/customer',52),
        (12,'sale/customer_group',53),
        (12,'sale/coupon',54),
        (12,'sale/contact',55);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (13,'sale',51),
        (13,'sale',52),
        (13,'sale',53),
        (13,'sale',54),
        (13,'sale',55);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES  (14,1,51),
        (14,2,52),
        (14,3,53),
        (14,4,54),
        (14,5,55);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (15,'core',51),
        (15,'core',52),
        (15,'core',53),
        (15,'core',54),
        (15,'core',55);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'221',51),
        (40,'222',52),
        (40,'223',53),
        (40,'224',54),
        (40,'225',55);

--		
-- SUBMENU SYSTEM
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (10,'setting',71),
        (10,'users',72),
        (10,'localisation',73),
        (10,'data',74),
        (10,'updater',77),
        (10,'cache',78),
        (10,'messages',79),
        (10,'logs',80);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (11,'text_setting',71),
        (11,'text_users',72),
        (11,'text_localisation',73),
        (11,'text_data',74),
        (11,'text_updater',77),
        (11,'text_cache',78),
        (11,'text_messages',79),
        (11,'text_logs',80);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (12,'setting/setting',71),
        (12,'',72),
        (12,'',73),
        (12,'',74),
        (12,'tool/updater',77),
        (12,'tool/cache',78),
        (12,'tool/message_manager',79),
        (12,'',80);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (13,'system',71),
        (13,'system',72),
        (13,'system',73),
        (13,'system',74),
        (13,'system',77),
        (13,'system',78),
        (13,'system',79),
        (13,'system',80);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES  (14,1,71),
        (14,2,72),
        (14,3,73),
        (14,4,74),
        (14,7,77),
        (14,8,78),
        (14,9,79),
        (14,10,80);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (15,'core',71),
        (15,'core',72),
        (15,'core',73),
        (15,'core',74),
        (15,'core',77),
        (15,'core',78),
        (15,'core',79),
        (15,'core',80);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'226',71),
        (40,'227',72),
        (40,'228',73),
        (40,'229',74),
        (40,'230',77),
        (40,'231',78),
        (40,'232',79),
        (40,'233',80);


--
-- SUBMENU REPORTS
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (10,'report_sale',91),
        (10,'report_customer',92),
        (10,'report_product',93),
        (10,'banner_manager_stat',94 );
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (11,'text_report_sale',91),
        (11,'text_customer',92),
        (11,'text_product',93),
        (11,'banner_manager_name_stat',94);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (12,'',91),
        (12,'',92),
        (12,'',93),
        (12,'extension/banner_manager_stat',94);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (13,'reports',91),
        (13,'reports',92),
        (13,'reports',93),
        (13,'reports',94);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES  (14,1,91),
        (14,2,92),
        (14,3,93),
        (14,4,94);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (15,'core',91),
        (15,'core',92),
        (15,'core',93),
        (15,'extension',94);

-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'234',91),
        (40,'222',92),
        (40,'208',93),
        (40,'237',94);

--
-- SUBMENU HELP
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (10,'abantecart',111),
        (10,'documentation',112),
        (10,'support',113),
        (10,'marketplace',114);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (11,'text_abantecart',111),
        (11,'text_documentation',112),
        (11,'text_support',113),
        (11,'text_extensions_store',114);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (12,'window.open(\'http://www.abantecart.ir\');',111),
        (12,'window.open(\'http://www.abantecart.ir/ecommerce-documentation\');',112),
        (12,'window.open(\'http://forum.abantecart.ir\');',113),
        (12,'window.open(\'http://marketplace.abantecart.com\');',114);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (13,'help',111),
        (13,'help',112),
        (13,'help',113),
        (13,'help',114);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES  (14,1,111),
        (14,2,112),
        (14,3,113),
        (14,4,114);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (15,'core',111),
        (15,'core',112),
        (15,'core',113),
        (15,'core',114);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'238',111),
        (40,'239',112),
        (40,'240',113),
        (40,'203',114);

--		
-- SUBMENU DESIGN
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (10,'template',131),
        (10,'layout',132),
        (10,'blocks',133),
        (10,'menu',134),
        (10,'content',135),
		    (10,'banner_manager',136),
		    (10,'forms_manager',200);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (11,'text_templates',131),
        (11,'text_layout',132),
        (11,'text_blocks',133),
        (11,'text_menu',134),
        (11,'text_content',135),
        (11,'banner_manager_name',136),
        (11,'forms_manager_name',200);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (12,'extension/extensions/template',131),
        (12,'design/layout',132),
        (12,'design/blocks',133),
        (12,'design/menu',134),
        (12,'design/content',135),
        (12,'extension/banner_manager',136),
        (12,'tool/forms_manager',200);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (13,'design',131),
        (13,'design',132),
        (13,'design',133),
        (13,'design',134),
        (13,'design',135),
        (13,'design',136),
        (13,'design',200);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES  (14,1,131),
        (14,2,132),
        (14,3,133),
        (14,4,134),
        (14,5,135),
        (14,6,136),
        (14,7,200);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (15,'core',131),
        (15,'core',132),
        (15,'core',133),
        (15,'core',134),
        (15,'core',135),
        (15,'extension',136),
        (15,'extension',200);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'241',131),
        (40,'242',132),
        (40,'243',133),
        (40,'244',134),
        (40,'245',135),
        (40,'246',136),
        (40,'248',200);


--
-- SUBMENU SYSTEM->SETTINGS
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(10,'all_settings',191),
(10,'settings_details',192),
(10,'settings_general',193),
(10,'settings_checkout',194),
(10,'settings_appearance',195),
(10,'settings_mail',196),
(10,'settings_api',197),
(10,'settings_system',198),
(10,'settings_newstore',199);

-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(11,'text_all_settings',191),
(11,'text_settings_details',192),
(11,'text_settings_general',193),
(11,'text_settings_checkout',194),
(11,'text_settings_appearance',195),
(11,'text_settings_mail',196),
(11,'text_settings_api',197),
(11,'text_settings_system',198),
(11,'text_settings_newstore',199);

-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(12,'setting/setting/all',191),
(12,'setting/setting/details',192),
(12,'setting/setting/general',193),
(12,'setting/setting/checkout',194),
(12,'setting/setting/appearance',195),
(12,'setting/setting/mail',196),
(12,'setting/setting/api',197),
(12,'setting/setting/system',198),
(12,'setting/store/insert',199);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(13,'setting',191),
(13,'setting',192),
(13,'setting',193),
(13,'setting',194),
(13,'setting',195),
(13,'setting',196),
(13,'setting',197),
(13,'setting',198),
(13,'setting',199);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES
(14,1,191),
(14,2,192),
(14,3,193),
(14,4,194),
(14,5,195),
(14,6,196),
(14,7,197),
(14,8,198),
(14,9,199);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(15,'core',191),
(15,'core',192),
(15,'core',193),
(15,'core',194),
(15,'core',195),
(15,'core',196),
(15,'core',197),
(15,'core',198),
(15,'core',199);

-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'247',191),
        (40,'248',192),
        (40,'249',193),
        (40,'250',194),
        (40,'251',195),
        (40,'252',196),
        (40,'253',197),
        (40,'254',198),
        (40,'255',199);


--
-- SUBMENU USERS OF SUBMENU SYSTEM
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (10,'user',151),
		    (10,'permission',152);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (11,'text_user',151),
		    (11,'text_user_group',152);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (12,'user/user',151),
	    	(12,'user/user_permission',152);
-- PARENT_ID	(submenu SYSTEM)
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (13,'users',151),
		    (13,'users',152);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`)
VALUES  (14,1,151),
	    	(14,2,152);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (15,'core',151),
		    (15,'core',152);

-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'256',151),
        (40,'257',152);

--		
-- SUBMENU SYSTEM->LOCALIZATION
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (10,'language',171),
        (10,'language_definitions',172),
        (10,'currency',173),
        (10,'stockstatus',174),
        (10,'orderstatus',175),
        (10,'country',176),
        (10,'zone',177),
        (10,'location',178),
        (10,'taxclass',179),
        (10,'lengthclass',180),
        (10,'weightclass',181);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (11,'text_language',171),
        (11,'text_language_definitions',172),
        (11,'text_currency',173),
        (11,'text_stock_status',174),
        (11,'text_order_status',175),
        (11,'text_country',176),
        (11,'text_zone',177),
        (11,'text_location',178),
        (11,'text_tax_class',179),
        (11,'text_length_class',180),
        (11,'text_weight_class',181);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (12,'localisation/language',171),
        (12,'localisation/language_definitions',172),
        (12,'localisation/currency',173),
        (12,'localisation/stock_status',174),
        (12,'localisation/order_status',175),
        (12,'localisation/country',176),
        (12,'localisation/zone',177),
        (12,'localisation/location',178),
        (12,'localisation/tax_class',179),
        (12,'localisation/length_class',180),
        (12,'localisation/weight_class',181);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (13,'localisation',171),
        (13,'localisation',172),
        (13,'localisation',173),
        (13,'localisation',174),
        (13,'localisation',175),
        (13,'localisation',176),
        (13,'localisation',177),
        (13,'localisation',178),
        (13,'localisation',179),
        (13,'localisation',180),
        (13,'localisation',181);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES  (14,1,171),
        (14,2,172),
        (14,3,173),
        (14,4,174),
        (14,5,175),
        (14,6,176),
        (14,7,177),
        (14,8,178),
        (14,9,179),
        (14,10,180),
        (14,11,181);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES  (15,'core',171),
        (15,'core',172),
        (15,'core',173),
        (15,'core',174),
        (15,'core',175),
        (15,'core',176),
        (15,'core',177),
        (15,'core',178),
        (15,'core',179),
        (15,'core',180),
        (15,'core',181);

-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'258',171),
        (40,'259',172),
        (40,'260',173),
        (40,'261',174),
        (40,'262',175),
        (40,'263',176),
        (40,'264',177),
        (40,'265',178),
        (40,'266',179),
        (40,'267',180),
        (40,'268',181);
--
-- SUBMENU SYSTEM->DATA
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (10,'backup',183),
        (10,'migrate',184),
        (10,'datasets',185),
        (10,'import_export',182),
        (10,'file_uploads',188);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (11,'text_backup',183),
        (11,'text_migrate',184),
        (11,'text_datasets_manager',185),
        (11,'text_import_export',182),
        (11,'text_file_uploads',188);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (12,'tool/backup',183),
        (12,'tool/migration/step_one',184),
        (12,'tool/datasets_manager',185),
        (12,'tool/import_export',182),
        (12, 'tool/files',188);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (13,'data',183),
        (13,'data',184),
        (13,'data',185),
        (13,'data',182),
        (13,'data',188);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`)
VALUES  (14,1,183),
        (14,2,184),
        (14,3,185),
        (14,4,182),
        (14,5,188);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (15,'core',183),
        (15,'core',184),
        (15,'core',185),
        (15,'core',182),
        (15,'core',188);

-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'269',183),
        (40,'270',184),
        (40,'271',185),
        (40,'272',182),
        (40,'273',188);

--
-- SUBMENU SYSTEM->LOGS
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (10,'installlog',186),
		    (10,'error_log',187),
		    (10,'task',189);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (11,'text_install_upgrade_history',186),
		    (11,'text_error_log',187),
		    (11,'text_tasks',189);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (12,'tool/install_upgrade_history',186),
		    (12,'tool/error_log',187),
		    (12,'tool/task',189);
-- PARENT_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (13,'logs',186),
		    (13,'logs',187),
		    (13,'logs',189);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`)
VALUES  (14,1,186),
	    	(14,2,187),
	    	(14,3,189);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (15,'core',186),
		    (15,'core',187),
		    (15,'core',189);

-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'274',186),
        (40,'275',187),
        (40,'254',189);


--
-- SUBMENU REPORTS->SALES
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(10,'report_sale_orders',210),
(10,'report_sale_tax',211),
(10,'report_sale_shipping',212),
(10,'report_sale_coupon',213);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(11,'text_order',210),
(11,'text_tax',211),
(11,'text_shipping',212),
(11,'text_discount',213);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(12,'report/sale/orders',210),
(12,'report/sale/taxes',211),
(12,'report/sale/shipping',212),
(12,'report/sale/coupons',213);
-- PARENT_ID	
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(13,'report_sale',210),
(13,'report_sale',211),
(13,'report_sale',212),
(13,'report_sale',213);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES
(14,1,210),
(14,2,211),
(14,3,212),
(14,4,213);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(15,'core',210),
(15,'core',211),
(15,'core',212),
(15,'core',213);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'221',210),
        (40,'266',211),
        (40,'214',212),
        (40,'224',213);

--
-- SUBMENU REPORTS->CUSTOMERS
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(10,'report_customer_online',214),
(10,'report_customer_order',215),
(10,'report_customer_transactions',216);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(11,'text_online',214),
(11,'text_order',215),
(11,'text_transactions',216);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(12,'report/customer/online',214),
(12,'report/customer/orders',215),
(12,'report/customer/transactions',216);
-- PARENT_ID	
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(13,'report_customer',214),
(13,'report_customer',215),
(13,'report_customer',216);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES
(14,1,214),
(14,2,215),
(14,3,216);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(15,'core',214),
(15,'core',215),
(15,'core',216);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'222',214),
        (40,'221',215),
        (40,'260',216);
        
--
-- SUBMENU REPORTS->PRODUCTS
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(10,'report_product_viewed',217),
(10,'report_product_purchased',218);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(11,'text_report_viewed',217),
(11,'text_report_purchased',218);
-- ITEM_URL
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(12,'report/viewed',217),
(12,'report/purchased',218);
-- PARENT_ID	
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(13,'report_product',217),
(13,'report_product',218);
-- SORT_ORDER
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`) 
VALUES
(14,1,217),
(14,2,218);
-- ITEM_TYPE
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`) 
VALUES
(15,'core',217),
(15,'core',218);
-- ITEM_RL_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (40,'235',217),
        (40,'236',218);
                
--
-- Storefront menu names inserts
--
INSERT INTO `ac_datasets` (`dataset_name`,`dataset_key`) VALUES ('menu','storefront_description');
INSERT INTO `ac_dataset_definition` (`dataset_id`,`dataset_column_id`,`dataset_column_name`,`dataset_column_type`,`dataset_column_sort_order`)
VALUES  (3,16, 'item_id','varchar',1),
        (3,17, 'item_text','varchar',2),
        (3,18, 'language_id','integer',3);
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (16,'home',1),
        (16,'login',2),
        (16,'logout',3),
        (16,'account',4),
        (16,'cart',5),
        (16,'checkout',6),
        (16,'specials',14);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (17,'Home',1),
        (17,'Login',2),
        (17,'Logout',3),
        (17,'Account',4),
        (17,'Cart',5),
        (17,'Checkout',6),
        (17,'Specials',14);
-- LANGUAGE_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`)
VALUES  (18,1,1),
        (18,1,2),
        (18,1,3),
        (18,1,4),
        (18,1,5),
        (18,1,6),
        (18,1,14);
-- spanish
-- ITEM_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (16,'home',7),
        (16,'login',8),
        (16,'logout',9),
        (16,'account',10),
        (16,'cart',11),
        (16,'checkout',12),
        (16,'specials',13);
-- ITEM_TEXT
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (17,'Casa',7),
        (17,'Iniciar Sesión',8),
        (17,'Cerrar sesión',9),
        (17,'Cuenta',10),
        (17,'Carro',11),
        (17,'Caja',12),
        (17,'Especiales',13);
-- LANGUAGE_ID
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_integer`,`row_id`)
VALUES  (18,9,7),
        (18,9,8),
        (18,9,9),
        (18,9,10),
        (18,9,11),
        (18,9,12),
        (18,9,13);



-- ## ADD INSTALL/UPGRADE HISTORY DATASET
INSERT INTO `ac_datasets` (`dataset_name`,`dataset_key`) VALUES ('install_upgrade_history','admin');
INSERT INTO `ac_dataset_properties` (`dataset_id`,`dataset_property_name`,`dataset_property_value`) VALUES ('4','controller','tool/install_upgrade_history');

INSERT INTO `ac_dataset_definition` (`dataset_id`,`dataset_column_id`, `dataset_column_name`,`dataset_column_type`,`dataset_column_sort_order`)
VALUES  (4,20,'date_added','timestamp',1),
        (4,21,'name','varchar',2),
        (4,22,'version','varchar',3),
        (4,23,'backup_file','varchar',4),
        (4,24,'backup_date','timestamp',5),
        (4,25,'type','varchar',6),
        (4,26,'user','varchar',7);


-- insert info about initial installation
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_timestamp`,`row_id`)
VALUES  (20, NOW(),'1');
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (21,'AbanteCart','1');
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (22,'1.2.3','1');
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (23,'','1');
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (24,'','1');
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (25,'install','1');
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (26,'admin','1');




-- ## ADD FILE UPLOADS DATASET
INSERT INTO `ac_datasets` (`dataset_id`,`dataset_name`,`dataset_key`) VALUES (5,'file_uploads','admin');
INSERT INTO `ac_dataset_properties` (`dataset_id`,`dataset_property_name`,`dataset_property_value`) VALUES (5,'controller','tool/files');

INSERT INTO `ac_dataset_definition` (`dataset_id`,`dataset_column_id`, `dataset_column_name`,`dataset_column_type`,`dataset_column_sort_order`)
VALUES  (5,30,'date_added','timestamp',1),
        (5,31,'name','varchar',2),
        (5,32,'type','varchar',3),
        (5,33,'section','varchar',4),
        (5,34,'section_id','integer',5),
        (5,35,'path','varchar',6);

--
-- DDL for table `ac_resource_library`
--
DROP TABLE IF EXISTS `ac_resource_library`;
CREATE TABLE `ac_resource_library` (
  `resource_id` int(11) NOT NULL NULL auto_increment,
  `type_id` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`resource_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=100000;

--
-- DDL for table `ac_resource_descriptions`
--
		
DROP TABLE IF EXISTS `ac_resource_descriptions`;
CREATE TABLE `ac_resource_descriptions` (
  `resource_id` int(10) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL, -- use 1 as default
  `name` varchar(255) NOT NULL DEFAULT '' NULL COMMENT 'translatable',
  `title` varchar(255) NOT NULL DEFAULT '' NULL COMMENT 'translatable',
  `description` text DEFAULT NULL NULL COMMENT 'translatable',
  `resource_path` varchar(255) DEFAULT NULL,
  `resource_code` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`resource_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ;



#storefront menu icons
INSERT INTO `ac_resource_library` ( `resource_id`, `type_id`, `date_added`)
VALUES
(1,1,now()),
(2,1,now()),
(3,1,now()),
(4,1,now()),
(5,1,now()),
(6,1,now());

INSERT INTO `ac_resource_descriptions`
(`resource_id`, `language_id`, `name`, `title`, `description`, `resource_path`, `resource_code`, `date_added`)
VALUES
(1,1,'Star Icon','','','','<i class="fa fa-star"></i>&nbsp;&nbsp;',now()),
(2,1,'Icon Home','','','','<i class="fa fa-home"></i>&nbsp;',now()),
(3,1,'Login Icon','','','','<i class="fa fa-lock"></i>&nbsp;&nbsp;',now()),
(4,1,'Account Icon','','','','<i class="fa fa-user"></i>&nbsp;',now()),
(5,1,'Cart Icon','','','','<i class="fa fa-shopping-cart"></i>&nbsp;',now()),
(6,1,'Checkout Icon','','','','<i class="fa fa-barcode"></i>&nbsp;&nbsp;',now());

#Admin Menu Icons
INSERT INTO `ac_resource_library` ( `resource_id`, `type_id`, `date_added`)
VALUES
  ( 200, 1, NOW() ),
  ( 201, 1, NOW() ),
  ( 202, 1, NOW() ),
  ( 203, 1, NOW() ),
  ( 204, 1, NOW() ),
  ( 205, 1, NOW() ),
  ( 206, 1, NOW() ),
  ( 207, 1, NOW() ),
  ( 208, 1, NOW() ),
  ( 209, 1, NOW() ),
  ( 210, 1, NOW() ),
  ( 211, 1, NOW() ),
  ( 212, 1, NOW() ),
  ( 213, 1, NOW() ),
  ( 214, 1, NOW() ),
  ( 215, 1, NOW() ),
  ( 216, 1, NOW() ),
  ( 217, 1, NOW() ),
  ( 218, 1, NOW() ),
  ( 219, 1, NOW() ),
  ( 220, 1, NOW() ),
  ( 221, 1, NOW() ),
  ( 222, 1, NOW() ),
  ( 223, 1, NOW() ),
  ( 224, 1, NOW() ),
  ( 225, 1, NOW() ),
  ( 226, 1, NOW() ),
  ( 227, 1, NOW() ),
  ( 228, 1, NOW() ),
  ( 229, 1, NOW() ),
  ( 230, 1, NOW() ),
  ( 231, 1, NOW() ),
  ( 232, 1, NOW() ),
  ( 233, 1, NOW() ),
  ( 234, 1, NOW() ),
  ( 235, 1, NOW() ),
  ( 236, 1, NOW() ),
  ( 237, 1, NOW() ),
  ( 238, 1, NOW() ),
  ( 239, 1, NOW() ),
  ( 240, 1, NOW() ),
  ( 241, 1, NOW() ),
  ( 242, 1, NOW() ),
  ( 243, 1, NOW() ),
  ( 244, 1, NOW() ),
  ( 245, 1, NOW() ),
  ( 246, 1, NOW() ),
  ( 247, 1, NOW() ),
  ( 248, 1, NOW() ),
  ( 249, 1, NOW() ),
  ( 250, 1, NOW() ),
  ( 251, 1, NOW() ),
  ( 252, 1, NOW() ),
  ( 253, 1, NOW() ),
  ( 254, 1, NOW() ),
  ( 255, 1, NOW() ),
  ( 256, 1, NOW() ),
  ( 257, 1, NOW() ),
  ( 258, 1, NOW() ),
  ( 259, 1, NOW() ),
  ( 260, 1, NOW() ),
  ( 261, 1, NOW() ),
  ( 262, 1, NOW() ),
  ( 263, 1, NOW() ),
  ( 264, 1, NOW() ),
  ( 265, 1, NOW() ),
  ( 266, 1, NOW() ),
  ( 267, 1, NOW() ),
  ( 268, 1, NOW() ),
  ( 269, 1, NOW() ),
  ( 270, 1, NOW() ),
  ( 271, 1, NOW() ),
  ( 272, 1, NOW() ),
  ( 273, 1, NOW() ),
  ( 274, 1, NOW() ),
  ( 275, 1, NOW() );

INSERT INTO `ac_resource_descriptions`
(`resource_id`, `language_id`, `name`, `title`, `description`, `resource_path`, `resource_code`, `date_added`)
VALUES
  ( 200,1,'Icon Catalog', '', '', '', '<i class="fa fa-folder-open"></i>&nbsp;', NOW() ),
  ( 201,1,'Icon Sale', '', '', '', '<i class="fa fa-flag-o"></i>&nbsp;', NOW() ),
  ( 202,1,'Icon Design', '', '', '', '<i class="fa fa-file-text"></i>&nbsp;', NOW() ),
  ( 203,1,'Icon Extension', '', '', '', '<i class="fa fa-puzzle-piece"></i>&nbsp;', NOW() ),
  ( 204,1,'Icon System', '', '', '', '<i class="fa fa-wrench"></i>&nbsp;', NOW() ),
  ( 205,1,'Icon Reports', '', '', '', '<i class="fa fa-bar-chart-o"></i>&nbsp;', NOW() ),
  ( 206,1,'Icon Help', '', '', '', '<i class="fa fa-life-ring"></i>&nbsp;', NOW() ),
  ( 207,1,'Icon Category', '', '', '', '<i class="fa fa-folder-open"></i>&nbsp;', NOW() ),
  ( 208,1,'Icon Product', '', '', '', '<i class="fa fa-cubes"></i>&nbsp;', NOW() ),
  ( 209,1,'Icon Manufacturer', '', '', '', '<i class="fa fa-bookmark-o"></i>&nbsp;', NOW() ),
  ( 210,1,'Icon Download', '', '', '', '<i class="fa fa-upload"></i>&nbsp;', NOW() ),
  ( 211,1,'Icon Review', '', '', '', '<i class="fa fa-comment-o"></i>&nbsp;', NOW() ),
  ( 212,1,'Icon Attributes', '', '', '', '<i class="fa fa-ticket"></i>&nbsp;', NOW() ),
  ( 213,1,'Icon Extensions', '', '', '', '<i class="fa fa-th"></i>&nbsp;', NOW() ),
  ( 214,1,'Icon Shipping', '', '', '', '<i class="fa fa-truck"></i>&nbsp;', NOW() ),
  ( 215,1,'Icon Payment', '', '', '', '<i class="fa fa-university"></i>&nbsp;', NOW() ),
  ( 216,1,'Icon Templates', '', '', '', '<i class="fa fa-outdent"></i>&nbsp;', NOW() ),
  ( 217,1,'Icon Languages', '', '', '', '<i class="fa fa-language"></i>&nbsp;', NOW() ),
  ( 218,1,'Icon Total', '', '', '', '<i class="fa fa-sign-in"></i>&nbsp;', NOW() ),
  ( 219,1,'Icon Add extension', '', '', '', '<i class="fa fa-paperclip"></i>&nbsp;', NOW() ),
  ( 220,1,'Icon Extensions stores', '', '', '', '<i class="fa fa-arrows-alt"></i>&nbsp;', NOW() ),
  ( 221,1,'Icon Order', '', '', '', '<i class="fa fa-flag-checkered"></i>&nbsp;', NOW() ),
  ( 222,1,'Icon Customer', '', '', '', '<i class="fa fa-users"></i>&nbsp;', NOW() ),
  ( 223,1,'Icon Customer group', '', '', '', '<i class="fa fa-book"></i>&nbsp;', NOW() ),
  ( 224,1,'Icon Coupon', '', '', '', '<i class="fa fa-tags"></i>&nbsp;', NOW() ),
  ( 225,1,'Icon Contact', '', '', '', '<i class="fa fa-envelope-o"></i>&nbsp;', NOW() ),
  ( 226,1,'Icon Setting', '', '', '', '<i class="fa fa-cogs"></i>&nbsp;', NOW() ),
  ( 227,1,'Icon Users', '', '', '', '<i class="fa fa-users"></i>&nbsp;', NOW() ),
  ( 228,1,'Icon Localisation', '', '', '', '<i class="fa fa-random"></i>&nbsp;', NOW() ),
  ( 229,1,'Icon Data', '', '', '', '<i class="fa fa-cubes"></i>&nbsp;', NOW() ),
  ( 230,1,'Icon Updater', '', '', '', '<i class="fa fa-refresh"></i>&nbsp;', NOW() ),
  ( 231,1,'Icon Cache', '', '', '', '<i class="fa fa-recycle"></i>&nbsp;', NOW() ),
  ( 232,1,'Icon Messages', '', '', '', '<i class="fa fa-weixin"></i>&nbsp;', NOW() ),
  ( 233,1,'Icon Logs', '', '', '', '<i class="fa fa-floppy-o"></i>&nbsp;', NOW() ),
  ( 234,1,'Icon Report sale', '', '', '', '<i class="fa fa-signal"></i>&nbsp;', NOW() ),
  ( 235,1,'Icon Viewed', '', '', '', '<i class="fa fa-sort-amount-desc"></i>&nbsp;', NOW() ),
  ( 236,1,'Icon Purchased', '', '', '', '<i class="fa fa-file-text-o"></i>&nbsp;', NOW() ),
  ( 237,1,'Icon Banner manager stat', '', '', '', '<i class="fa fa-reply-all"></i>&nbsp;', NOW() ),
  ( 238,1,'Icon Abantecart', '', '', '', '<i class="fa fa-external-link"></i>&nbsp;', NOW() ),
  ( 239,1,'Icon Documentation', '', '', '', '<i class="fa fa-graduation-cap"></i>&nbsp;', NOW() ),
  ( 240,1,'Icon Support', '', '', '', '<i class="fa fa-info"></i>&nbsp;', NOW() ),
  ( 241,1,'Icon Template', '', '', '', '<i class="fa fa-files-o"></i>&nbsp;', NOW() ),
  ( 242,1,'Icon Layout', '', '', '', '<i class="fa fa-bars"></i>&nbsp;', NOW() ),
  ( 243,1,'Icon Blocks', '', '', '', '<i class="fa fa-qrcode"></i>&nbsp;', NOW() ),
  ( 244,1,'Icon Menu', '', '', '', '<i class="fa fa-tag"></i>&nbsp;', NOW() ),
  ( 245,1,'Icon Content', '', '', '', '<i class="fa fa-clipboard"></i>&nbsp;', NOW() ),
  ( 246,1,'Icon Banner manager', '', '', '', '<i class="fa fa-picture-o"></i>&nbsp;', NOW() ),
  ( 247,1,'Icon All settings', '', '', '', '<i class="fa fa-sliders"></i>&nbsp;', NOW() ),
  ( 248,1,'Icon Settings details', '', '', '', '<i class="fa fa-list"></i>&nbsp;', NOW() ),
  ( 249,1,'Icon Settings general', '', '', '', '<i class="fa fa-folder-o"></i>&nbsp;', NOW() ),
  ( 250,1,'Icon Settings checkout', '', '', '', '<i class="fa fa-shopping-cart"></i>&nbsp;', NOW() ),
  ( 251,1,'Icon Settings appearance', '', '', '', '<i class="fa fa-pencil-square-o"></i>&nbsp;', NOW() ),
  ( 252,1,'Icon Settings mail', '', '', '', '<i class="fa fa-envelope-square"></i>&nbsp;', NOW() ),
  ( 253,1,'Icon Settings api', '', '', '', '<i class="fa fa-slack"></i>&nbsp;', NOW() ),
  ( 254,1,'Icon Settings system', '', '', '', '<i class="fa fa-tasks"></i>&nbsp;', NOW() ),
  ( 255,1,'Icon Settings newstore', '', '', '', '<i class="fa fa-sitemap"></i>&nbsp;', NOW() ),
  ( 256,1,'Icon User', '', '', '', '<i class="fa fa-male"></i>&nbsp;', NOW() ),
  ( 257,1,'Icon Permission', '', '', '', '<i class="fa fa-code-fork"></i>&nbsp;', NOW() ),
  ( 258,1,'Icon Language', '', '', '', '<i class="fa fa-language"></i>&nbsp;', NOW() ),
  ( 259,1,'Icon Language definitions', '', '', '', '<i class="fa fa-sort-alpha-asc"></i>&nbsp;', NOW() ),
  ( 260,1,'Icon Currency', '', '', '', '<i class="fa fa-money"></i>&nbsp;', NOW() ),
  ( 261,1,'Icon Stockstatus', '', '', '', '<i class="fa fa-list-alt"></i>&nbsp;', NOW() ),
  ( 262,1,'Icon Orderstatus', '', '', '', '<i class="fa fa-sort-amount-asc"></i>&nbsp;', NOW() ),
  ( 263,1,'Icon Country', '', '', '', '<i class="fa fa-globe"></i>&nbsp;', NOW() ),
  ( 264,1,'Icon Zone', '', '', '', '<i class="fa fa-thumb-tack"></i>&nbsp;', NOW() ),
  ( 265,1,'Icon Location', '', '', '', '<i class="fa fa-flag-checkered"></i>&nbsp;', NOW() ),
  ( 266,1,'Icon Taxclass', '', '', '', '<i class="fa fa-briefcase"></i>&nbsp;', NOW() ),
  ( 267,1,'Icon Lengthclass', '', '', '', '<i class="fa fa-arrows-h"></i>&nbsp;', NOW() ),
  ( 268,1,'Icon Weightclass', '', '', '', '<i class="fa fa-angle-double-down"></i>&nbsp;', NOW() ),
  ( 269,1,'Icon Backup', '', '', '', '<i class="fa fa-jsfiddle"></i>&nbsp;', NOW() ),
  ( 270,1,'Icon Migrate', '', '', '', '<i class="fa fa-share-alt-square"></i>&nbsp;', NOW() ),
  ( 271,1,'Icon Datasets', '', '', '', '<i class="fa fa-database"></i>&nbsp;', NOW() ),
  ( 272,1,'Icon Import export', '', '', '', '<i class="fa fa-exchange"></i>&nbsp;', NOW() ),
  ( 273,1,'Icon File uploads', '', '', '', '<i class="fa fa-download"></i>&nbsp;', NOW() ),
  ( 274,1,'Icon Installlog', '', '', '', '<i class="fa fa-history"></i>&nbsp;', NOW() ),
  ( 275,1,'Icon Error log', '', '', '', '<i class="fa fa-exclamation-triangle"></i>&nbsp;', NOW() );


--
-- DDL for table `ac_resource_types`
--
DROP TABLE IF EXISTS `ac_resource_types`;
CREATE TABLE `ac_resource_types` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(40) NOT NULL default '',
  `default_directory` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `default_icon` varchar(255) COLLATE utf8_general_ci DEFAULT NULL,
  `file_types` varchar(40) NOT NULL default '',
  `access_type`tinyint(1) NOT NULL default '0' COMMENT '0-Public, 1-Secured',
  PRIMARY KEY (`type_id`),
  KEY `group_id` (`type_id`, `type_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
		
INSERT INTO `ac_resource_types` (`type_id`, `type_name`, `default_icon`, `default_directory`, `file_types`, `access_type`) VALUES
(1, 'image', 'icon_resource_image.png', 'image/', '/.+(jpe?g|gif|png|ico)$/i', 0),
(2, 'audio', 'icon_resource_audio.png', 'audio/', '/.+(mp3|wav)$/i', 0),
(3, 'video', 'icon_resource_video.png', 'video/', '/.+(avi|mpg|mov|flv)$/i', 0),
(4, 'pdf', 'icon_resource_pdf.png', 'pdf_document/', '/.+(pdf)$/i', 0),
(5, 'archive', 'icon_resource_archive.png', 'download/', '/.+(zip|rar|gz|7z)$/i', 1),
(6, 'download', 'icon_resource_download.png', 'download/', '/.+$/i', 1);

--
-- DDL for table `ac_resource_map`
--
DROP TABLE IF EXISTS `ac_resource_map`;
CREATE TABLE `ac_resource_map` (
  `resource_id` int(11) NOT NULL NULL,
  `object_name` varchar(40) NOT NULl,
  `object_id` int(11) NOT NULL,  
  `default`tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-no, 1-Yes', 
  `sort_order` int(3) NOT NULL DEFAULT '0',  
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY ( `resource_id`, `object_name`, `object_id` )
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `ac_resource_map` ( `resource_id`, `object_name`, `object_id`, `default`, `sort_order`, `date_added`)
VALUES
(1,'storefront_menu_item',0,0,0, now()),
(2,'storefront_menu_item',0,0,0, now()),
(3,'storefront_menu_item',0,0,0, now()),
(4,'storefront_menu_item',0,0,0, now()),
(5,'storefront_menu_item',0,0,0, now()),
(6,'storefront_menu_item',0,0,0, now());


--		
-- DDL For Global Attributes 		
--		
		
DROP TABLE IF EXISTS `ac_global_attributes`;
CREATE TABLE `ac_global_attributes` (
  `attribute_id` 		int(11) NOT NULL AUTO_INCREMENT,
  `attribute_parent_id`	int(11) NOT NULL DEFAULT '0',
  `attribute_group_id` 	int(11),
  `attribute_type_id` 	int(11) NOT NULL,
  `element_type` 		char(1) NOT NULL DEFAULT 'I',
  -- I - text input, T - Text area, S - Select, M - multivalue select, C - Checkbox, R - radio buttons, U - File upload, H - Hidden, G -Checkbox Group, D - Date, E - time, K - Captcha
  `sort_order` 			int(3) NOT NULL DEFAULT '0',
  `required` 			smallint(1) NOT NULL default '0',
  `settings`			text COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` 				smallint(1) NOT NULL default '0',
  `regexp_pattern` varchar(255),
  PRIMARY KEY (`attribute_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_global_attributes_idx` ON `ac_global_attributes` ( `attribute_parent_id`, `attribute_group_id`, `attribute_type_id` );


DROP TABLE IF EXISTS `ac_global_attributes_descriptions`;
CREATE TABLE `ac_global_attributes_descriptions` (
  `attribute_id` 		int(11) NOT NULL,
  `language_id` 		int(11) NOT NULL,
  `name` 				varchar(64) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `error_text` 	varchar(255) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`attribute_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


DROP TABLE IF EXISTS `ac_global_attributes_values`;
CREATE TABLE `ac_global_attributes_values` (
  `attribute_value_id` 	int(11) NOT NULL AUTO_INCREMENT,
  `attribute_id` 		int(11) NOT NULL,
  `sort_order` 			int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`attribute_value_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
CREATE INDEX `ac_global_attributes_values_idx` ON `ac_global_attributes_values` ( `attribute_id` );

DROP TABLE IF EXISTS `ac_global_attributes_value_descriptions`;
CREATE TABLE `ac_global_attributes_value_descriptions` (
  `attribute_value_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `language_id`	int(11) NOT NULL,
  `value` text COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'translatable', 
  PRIMARY KEY (`attribute_value_id`, `attribute_id`, `language_id` )
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;	 


DROP TABLE IF EXISTS `ac_global_attributes_groups`;
CREATE TABLE `ac_global_attributes_groups` (
  `attribute_group_id` 	int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` 			int(3) NOT NULL DEFAULT '0',
  `status` 				smallint(1) NOT NULL default '0',
  PRIMARY KEY (`attribute_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `ac_global_attributes_groups_descriptions`;
CREATE TABLE `ac_global_attributes_groups_descriptions` (
  `attribute_group_id` 	int(11) NOT NULL,
  `language_id` 		int(11) NOT NULL,
  `name` 				varchar(64) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`attribute_group_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


DROP TABLE IF EXISTS `ac_global_attributes_types`;
CREATE TABLE `ac_global_attributes_types` (
  `attribute_type_id` 	int(11) NOT NULL AUTO_INCREMENT,
  `type_key` 			varchar(64) NOT NULL,
  `controller` 			varchar(100) NOT NULL,
  `sort_order` 			int(3) NOT NULL DEFAULT '0',
  `status` 				smallint(1) NOT NULL default '0',
  PRIMARY KEY (`attribute_type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;	

INSERT INTO `ac_global_attributes_types` (`attribute_type_id`, `type_key`, `controller`, `sort_order`, `status`) VALUES
(1, 'product_option', 'responses/catalog/attribute/getProductOptionSubform', 1, 1),
(2, 'download_attribute', 'responses/catalog/attribute/getDownloadAttributeSubform', 2, 1);


DROP TABLE IF EXISTS `ac_global_attributes_type_descriptions`;
CREATE TABLE `ac_global_attributes_type_descriptions` (
  `attribute_type_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `type_name` varchar(64) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`attribute_type_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='utf8_general_ci';

INSERT INTO `ac_global_attributes_type_descriptions` (`attribute_type_id`, `language_id`, `type_name`, `date_added`)
VALUES
(1, 1, 'Product Option', NOW()),
(2, 1, 'Download Attribute', NOW())
;

--
-- Product Features and Filters 
--

DROP TABLE IF EXISTS `ac_product_filters`;
CREATE TABLE `ac_product_filters` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT,
  `filter_type` char(1) NOT NULL DEFAULT '',  -- M - manufacture/brand, C - Category  based, F - Feature based, O - Option based, P - Price based 
  `categories_hash` text NOT NULL, -- Hash with selected categories, that are used. Default ALL categories.
  `feature_id` int(11),
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `status` smallint(1) NOT NULL default '0',
  PRIMARY KEY (`filter_id`),
  KEY `feature_id` (`feature_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


DROP TABLE IF EXISTS `ac_product_filter_descriptions`;
CREATE TABLE `ac_product_filter_descriptions` (
  `filter_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  `language_id` int(11) NOT NULL,
  PRIMARY KEY (`filter_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


DROP TABLE IF EXISTS `ac_product_filter_ranges`;
CREATE TABLE `ac_product_filter_ranges` (
  `range_id` int(11) NOT NULL AUTO_INCREMENT,
  `feature_id` int(11),
  `filter_id` int(11) NOT NULL,
  `from` decimal(12,2) NOT NULL DEFAULT '0.00',
  `to` decimal(12,2) NOT NULL DEFAULT '0.00',
  `sort_order` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`range_id`),
  KEY `from` (`from`,`to`),
  KEY `filter_id` (`filter_id`),
  KEY `feature_id` (`feature_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `ac_product_filter_ranges_descriptions`;
CREATE TABLE `ac_product_filter_ranges_descriptions` (
  `range_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'translatable',
  `language_id` int(11) NOT NULL,
  PRIMARY KEY (`range_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `ac_extension_dependencies`;
CREATE TABLE `ac_extension_dependencies` (
  `extension_id` int(11) NOT NULL,
  `extension_parent_id` int(11) NOT NULL,
  PRIMARY KEY (`extension_id`,`extension_parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `ac_encryption_keys`;
CREATE TABLE `ac_encryption_keys` (
  `key_id` int(3) NOT NULL AUTO_INCREMENT,
  `key_name` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` int(1) NOT NULL,  
  `comment` text COLLATE utf8_general_ci NOT NULL,  
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `encryption_keys_key_name` (`key_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `ac_tasks`;
CREATE TABLE `ac_tasks` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `starter` int(11) DEFAULT NULL, -- 0 - storefront, 1 - admin side, 2 - any
  `status` int(11) DEFAULT '0', -- 0 - disabled, 1 - scheduled, 2 - active
  `start_time` datetime DEFAULT NULL,
  `last_time_run` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `progress` int(11) NOT NULL DEFAULT '0', -- percentage of progress
  `last_result` int(11) NOT NULL DEFAULT '0', -- 0 - success, 1 - failed, 2 - interrupted
  `run_interval` INT(11) NOT NULL DEFAULT '0', -- interval in seconds since last run, 0 - without interval
  `max_execution_time` int(11) DEFAULT '0', -- maximum execution time for this task
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `task_name_idx` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `ac_task_details`;
CREATE TABLE `ac_task_details` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_by` varchar(255) DEFAULT '', -- task owner name
  `settings` text DEFAULT '', -- serialized array with paramenters
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `ac_task_steps`;
CREATE TABLE `ac_task_steps` (
  `step_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `sort_order` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0', -- 0 - disabled, 1 - scheduled, 2 - active
  `last_time_run` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_result` int(11) NOT NULL DEFAULT '0', -- 0 - success, 1 - failed, 2 - interrupted
  `max_execution_time` int(11) DEFAULT '0', -- maximum execution time for this task
  `controller` varchar(255) DEFAULT '',
  `settings` text DEFAULT '', -- serialized array with paramenters
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`, `step_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
