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
(1,'IR','IRN','',1,0);
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
(1,1,'جمهوری اسلامی ایران');


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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
(1, 'ایران', 'IRR', '', 'ریال', '0', '1.00000000', 1, '1394-05-27 11:29:14'),
(2, 'ایران', 'IRT', '', 'تومان', '0', '0.10000000', 1, '1394-05-27 11:29:14');

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
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
('Default'),
('Wholesalers'),
('Newsletter Subscribers');


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
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
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
  `date_installed` datetime NOT NULL default '0000-00-00 00:00:00',
  `date_added` datetime NOT NULL default '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`extension_id`),
  UNIQUE KEY `extension_key` (`key`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `extension`
--

INSERT INTO `ac_extensions` (`type`, `key`, `category`, `status`, `priority`, `version`, `license_key`, `date_installed`, `date_modified`, `date_added`) VALUES
('payment', 'default_cod', 'payment', 1, 1, '1.0', null, now(), now(), now() ),
('total', 'coupon', '', 1, 1, '1.0', null, now(), now(), now() ),
('total', 'shipping', 'shipping', 1, 1, '1.0', null, now(), now(), now() ),
('total', 'low_order_fee', '', 0, 1, '1.0', null, now(), now(), now() ),
('total', 'handling', '', 0, 1, '1.0', null, now(), now(), now() ),
('total', 'sub_total', '', 1, 1, '1.0', null, now(), now(), now() ),
('total', 'tax', '', 1, 1, '1.0', null, now(), now(), now() ),
('total', 'total', '', 1, 1, '1.0', null, now(), now(), now() ),
('total', 'balance', '', 1, 1, '1.0', null, now(), now(), now() ),

('block', 'cart', '', 1, 1, '1.0', null, now(), now(), now() ),
('block', 'category', '', 1, 1, '1.0', null, now(), now(), now() ),
('block', 'content', '', 1, 1, '1.0', null, now(), now(), now() ),
('block', 'manufacturer', '', 1, 1, '1.0', null, now(), now(), now() ),
('block', 'bestseller', '', 1, 1, '1.0', null, now(), now(), now() ),
('block', 'latest', '', 1, 1, '1.0', null, now(), now(), now() ),
('block', 'featured', '', 1, 1, '1.0', null, now(), now(), now() ),

('shipping', 'default_flat_rate_shipping', 'shipping', 1, 1, '1.0', null, now(), now(), now() ),

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
	`start_date` datetime NULL DEFAULT NULL,
	`end_date` datetime NULL DEFAULT NULL,
	`blank` tinyint(1) NOT NULL DEFAULT '0',
	`target_url` text COLLATE utf8_general_ci DEFAULT '',
	`sort_order` int(11) NOT NULL,
	`date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
	`date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`banner_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `ac_banner_descriptions`;
CREATE TABLE `ac_banner_descriptions` (
  `banner_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'translatable',
  `description` text COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  `meta` text(1500) DEFAULT '' COMMENT 'translatable',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`banner_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `ac_banner_stat`;
CREATE TABLE `ac_banner_stat` (
	`rowid` INT NOT NULL AUTO_INCREMENT,
  `banner_id` int(11) NOT NULL,
  `type` int(11) NOT NULL, -- 1 = view, 2 = click
  `time` datetime NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
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
(1, 'Persian', 'fa', 'fa_IR.UTF-8,fa_IR,persian', '', 'persian', 'persian', 1, 1);

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
  `date_added` datetime NOT NULL default '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
(1, 1, 'Centimeter', 'cm'),
(2, 1, 'Millimeter', 'mm'),
(3, 1, 'Inch', 'in');

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
  `date_modified` datetime NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP, 
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
  `time` datetime NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
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
  `date_modified` datetime NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP, 
  PRIMARY KEY (`order_id`, `type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS `ac_order_data_types`;
CREATE TABLE `ac_order_data_types` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'translatable',
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP, 
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
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
(0, 1, 'Incomplete'),
(1, 1, 'Pending'),
(2, 1, 'Processing'),
(3, 1, 'Shipped'),
(7, 1, 'Canceled'),
(5, 1, 'Completed'),
(8, 1, 'Denied'),
(9, 1, 'Canceled Reversal'),
(10, 1, 'Failed'),
(11, 1, 'Refunded'),
(12, 1, 'Reversed'),
(13, 1, 'Chargeback');

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
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
('details','config_country_id',223),
('details','config_zone_id',3655),
('details','config_storefront_language','en'),
('details','admin_language','en'),
('details','config_currency','USD'),
('details','config_currency_auto',0),
('details','config_length_class','in'),
('details','config_weight_class','lb'),
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

('default_cod', 'default_cod_sort_order', '1'),
('default_cod', 'default_cod_order_status_id', '1'),
('default_cod', 'default_cod_status', '1'),
('default_cod', 'default_cod_location_id', '0'),
('default_cod', 'default_cod_autoselect', '1'),

('default_flat_rate_shipping', 'default_flat_rate_shipping_cost', '2'),
('default_flat_rate_shipping', 'default_flat_rate_shipping_tax_class_id', '9'),
('default_flat_rate_shipping', 'default_flat_rate_shipping_location_id', '0'),
('default_flat_rate_shipping', 'default_flat_rate_shipping_status', '1'),
('default_flat_rate_shipping', 'default_flat_rate_shipping_sort_order', '1'),
('default_flat_rate_shipping', 'default_flat_rate_shipping_autoselect', '1'),

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
(1, 1, 'In Stock'),
(2, 1, 'Out Of Stock'),
(3, 1, 'Pre-Order');

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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

--
-- Dumping data for table `user_group`
--

INSERT INTO `ac_user_groups` (`user_group_id`, `name`, `permission`) VALUES
(1, 'Top Administrator', ''),
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
(1, 1, 'Kilogram', 'kg'),
(2, 1, 'Gram', 'g'),
(5, 1, 'Pound ', 'lb'),
(6, 1, 'Ounce', 'oz');

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
(1, 1, 'TEH', 1, 0),
(2, 1, 'QOM', 1, 0),
(3, 1, 'MKZ', 1, 0),
(5, 1, 'QAZ', 1, 0),
(6, 1, 'GIL', 1, 0),
(4, 1, 'ARD', 1, 0),
(7, 1, 'ZAN', 1, 0),
(8, 1, 'EAZ', 1, 0),
(9, 1, 'WEZ', 1, 0),
(10, 1, 'KRD', 1, 0),
(11, 1, 'HMD', 1, 0),
(12, 1, 'KRM', 1, 0),
(13, 1, 'ILM', 1, 0),
(14, 1, 'LRS', 1, 0),
(15, 1, 'KZT', 1, 0),
(16, 1, 'CMB', 1, 0),
(17, 1, 'KBA', 1, 0),
(18, 1, 'BSH', 1, 0),
(19, 1, 'FAR', 1, 0),
(20, 1, 'HRM', 1, 0),
(21, 1, 'SBL', 1, 0),
(22, 1, 'KRB', 1, 0),
(23, 1, 'YZD', 1, 0),
(24, 1, 'EFH', 1, 0),
(25, 1, 'SMN', 1, 0),
(26, 1, 'MZD', 1, 0),
(27, 1, 'GLS', 1, 0),
(28, 1, 'NKH', 1, 0),
(29, 1, 'RKH', 1, 0),
(30, 1, 'SKH', 1, 0);


DROP TABLE IF EXISTS `ac_zone_descriptions`;
CREATE TABLE `ac_zone_descriptions` (
  `zone_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_general_ci NOT NULL COMMENT 'translatable',
  PRIMARY KEY (`zone_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


INSERT INTO `ac_zone_descriptions` (`zone_id`, `language_id`,`name`) VALUES 
(1, 1, 'تهران'),
(2, 1, 'قم'),
(3, 1, 'Markazi'),
(4, 1, 'Qazvin'),
(5, 1, 'Gilan'),
(6, 1, 'Ardabil'),
(7, 1, 'Zanjan'),
(8, 1, 'East Azarbaijan'),
(9, 1, 'West Azarbaijan'),
(10, 1, 'Kurdistan'),
(11, 1, 'Hamadan'),
(12, 1, 'Kermanshah'),
(13, 1, 'Ilam'),
(14, 1, 'Lorestan'),
(15, 1, 'Khuzestan'),
(16, 1, 'Chahar Mahaal and Bakhtiari'),
(17, 1, 'Kohkiluyeh and Buyer Ahmad'),
(18, 1, 'Bushehr'),
(19, 1, 'Fars'),
(20, 1, 'Hormozgan'),
(21, 1, 'Sistan and Baluchistan'),
(22, 1, 'Kerman'),
(23, 1, 'Yazd'),
(24, 1, 'Esfahan'),
(25, 1, 'Semnan'),
(26, 1, 'Mazandaran'),
(27, 1, 'Golestan'),
(28, 1, 'North Khorasan'),
(29, 1, 'Razavi Khorasan'),
(30, 1, 'South Khorasan');


--
-- DDL for table `zone_to_locations`
--
DROP TABLE IF EXISTS `ac_zones_to_locations`;
CREATE TABLE `ac_zones_to_locations` (
  `zone_to_location_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`zone_to_location_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

CREATE INDEX `ac_zones_to_locations_idx` ON `ac_zones_to_locations` ( `country_id`, `zone_id`, `location_id` );

--
-- Dumping data for table `ac_zones_to_locations`
--

INSERT INTO `ac_zones_to_locations` (`zone_to_location_id`, `country_id`, `zone_id`, `location_id`, `date_added`)
VALUES
	(1,1,1,1,now()),
	(2,1,2,1,now()),
	(3,1,3,1,now()),
	(4,1,4,1,now()),
	(5,1,5,1,now()),
	(6,1,6,1,now()),
	(7,1,7,1,now()),
	(8,1,8,1,now()),
	(9,1,9,1,now()),
	(10,1,10,1,now()),
	(11,1,11,1,now()),
	(12,1,12,1,now()),
	(13,1,13,1,now()),
	(14,1,14,1,now()),
	(15,1,15,1,now()),
	(16,1,16,1,now()),
	(17,1,17,1,now()),
	(18,1,18,1,now()),
	(19,1,19,1,now()),
	(20,1,20,1,now()),
	(21,1,21,1,now()),
	(22,1,22,1,now()),
	(23,1,23,1,now()),
	(24,1,24,1,now()),
	(25,1,25,1,now()),
	(26,1,26,1,now()),
	(27,1,27,1,now()),
	(28,1,28,1,now()),
	(29,1,29,1,now()),
	(30,1,30,1,now());

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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`page_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_page_descriptions` (`page_id`, `language_id`, `name`, `title`, `seo_url`, `keywords`, `description`, `content`, `date_added`) VALUES
(1, 1, 'All Other Pages', '', '', '', '', '', now() ),
(2, 1, 'Home Page', '', '', '', '', '', now() ),
(3, 1, 'Checkout Pages', '', '', '', '', '', now() ),
(4, 1, 'Login Page', '', '', '', '', '', now() ),
(5, 1, 'Default Product Page', '', '', '', '', '', now() ),
(10, 1, 'Maintenance Page', '', '', '', '', '', now() ),
(11, 1, 'Customer Account Pages', '', '', '', '', '', now() );

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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`content_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `ac_content_descriptions` (`content_id`, `language_id`, `name`, `title`, `description`, `content`, `date_added`)
VALUES
(1, 1, 'About Us', 'About Us', 'some description', 'text about your store', now() ),
(2, 1, 'Privacy Policy', 'Privacy Policy', 'some description', 'some text about privacy policy', now()),
(3, 1, 'Return Policy', 'Return Policy', 'some description', 'some text about return policy', now()),
(4, 1, 'Shipping', 'Shipping', 'some description', 'some text about shipping', now()),

(1, 9, 'Acerca de Nosotros', 'Acerca de Nosotros', 'alguna descripción', 'texto acerca de su tienda', now() ),
(2, 9, 'Política de Privacidad', 'Política de Privacidad', 'alguna descripción', 'un texto sobre la política', now()),
(3, 9, 'Política de devoluciones', 'Política de devoluciones', 'alguna descripción', 'un texto sobre la política de retorno', now()),
(4, 9, 'Entrega', 'Entrega', 'alguna descripción', 'un texto sobre el envío', now());

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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
(11,'First name:','Name must be between 3 and 32 characters!',1),
(12,'Email:','E-Mail Address does not appear to be valid!',1),
(13,'Enquiry:','Enquiry must be between 10 and 3000 characters!',1),
(14,'Enter the code in the box below:','Verification code does not match the image!',1);

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
  `start_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `end_date` datetime,
  `viewed_date` datetime,
  `viewed` int(11) NOT NULL default '0',
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `html` text,
  `url` text,
  `language_code` varchar(2) NOT NULL DEFAULT 'fa',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `value_timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
VALUES  (12,'window.open(\'http://www.abantecart.com\');',111),
        (12,'window.open(\'http://www.abantecart.com/ecommerce-documentation\');',112),
        (12,'window.open(\'http://forum.abantecart.com\');',113),
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
VALUES  (4,20,'date_added','datetime',1),
        (4,21,'name','varchar',2),
        (4,22,'version','varchar',3),
        (4,23,'backup_file','varchar',4),
        (4,24,'backup_date','datetime',5),
        (4,25,'type','varchar',6),
        (4,26,'user','varchar',7);


-- insert info about initial installation
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_timestamp`,`row_id`)
VALUES  (20, NOW(),'1');
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (21,'AbanteCart','1');
INSERT INTO `ac_dataset_values` (`dataset_column_id`, `value_varchar`,`row_id`)
VALUES  (22,'1.2.2','1');
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `last_time_run` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `progress` int(11) NOT NULL DEFAULT '0', -- percentage of progress
  `last_result` int(11) NOT NULL DEFAULT '0', -- 0 - success, 1 - failed, 2 - interrupted
  `run_interval` INT(11) NOT NULL DEFAULT '0', -- interval in seconds since last run, 0 - without interval
  `max_execution_time` int(11) DEFAULT '0', -- maximum execution time for this task
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `task_name_idx` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `ac_task_details`;
CREATE TABLE `ac_task_details` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_by` varchar(255) DEFAULT '', -- task owner name
  `settings` text DEFAULT '', -- serialized array with paramenters
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `ac_task_steps`;
CREATE TABLE `ac_task_steps` (
  `step_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `sort_order` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0', -- 0 - disabled, 1 - scheduled, 2 - active
  `last_time_run` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_result` int(11) NOT NULL DEFAULT '0', -- 0 - success, 1 - failed, 2 - interrupted
  `max_execution_time` int(11) DEFAULT '0', -- maximum execution time for this task
  `controller` varchar(255) DEFAULT '',
  `settings` text DEFAULT '', -- serialized array with paramenters
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`, `step_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci AUTO_INCREMENT=1;
