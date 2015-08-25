<?php echo $header; ?>
<div class="row">
	<div class="col-md-9">
	<div class="panel panel-default">

	<ul class="nav nav-tabs" role="tablist">
	  <li><a href="<?php echo $back; ?>">1: مجوز</a></li>
	  <li class="active"><a href="#" onclick="return false;">2: اعتبار سنجی سازگار</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">3: پیکربندی</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">4: بارگذاری داده ها</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">5: پایان</a></li>
	</ul>

	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	<div class="panel-heading">
	<h2><i class="fa fa-cogs fa-fw"></i> اعتبار سنجی سازگاری <small class="pull-left"><a onclick="document.getElementById('form').submit()" class="btn btn-primary">ادامه <i class="fa fa-arrow-left"></i></a></small></h2>
	</div>
	
	<div class="panel-body">

		<?php if ($error_warning) { ?>
		<div class="warning alert alert-error alert-danger"><?php echo $error_warning; ?></div>
		<?php } ?>
	
		<p>1. تنظیمات و پیکره بندی php مورد نیاز برای نصب.</p>
		
		<div class="section">
		    <table width="100%">
		    	<tr>
		    		<th width="35%" align="left"><b>PHP تنظيمات</b></th>
		    		<th width="25%" align="left"><b>تنظيمات فعلي</b></th>
		    		<th width="25%" align="left"><b>تنظیمات مورد نیاز</b></th>
		    		<th width="15%" align="center"><b>وضعيت</b></th>
		    	</tr>
		    	<tr>
		    		<td>PHP Version:</td>
		    		<td>><?php echo phpversion(); ?></td>
		    		<td>5.2+</td>
		    		<td align="center"><?php  echo (phpversion() >= '5.0') ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . '"image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    	<tr>
		    		<td>Register Globals:</td>
		    		<td><?php echo (ini_get('register_globals')) ? 'On' : 'Off'; ?></td>
		    		<td>Off</td>
		    		<td align="center"><?php echo (!ini_get('register_globals')) ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    	<tr>
		    		<td>Magic Quotes GPC:</td>
		    		<td><?php echo (ini_get('magic_quotes_gpc')) ? 'On' : 'Off'; ?></td>
		    		<td>Off</td>
		    		<td align="center"><?php echo (!ini_get('magic_quotes_gpc')) ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    	<tr>
		    		<td>File Uploads:</td>
		    		<td><?php echo (ini_get('file_uploads')) ? 'On' : 'Off'; ?></td>
		    		<td>On</td>
		    		<td align="center"><?php echo (ini_get('file_uploads')) ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    	<tr>
		    		<td>Session Auto Start:</td>
		    		<td><?php echo (ini_get('session_auto_start')) ? 'On' : 'Off'; ?></td>
		    		<td>Off</td>
		    		<td align="center"><?php echo (!ini_get('session_auto_start')) ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    	<tr>
		    		<td>Output Buffering</td>
		    		<td><?php echo (ini_get('output_buffering')) ? 'On' : 'Off'; ?></td>
		    		<td>On</td>
		    		<td align="center"><?php echo (ini_get('output_buffering')) ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    </table>
		</div>
		<p>2. اکستنشن های مورد نیاز برای نصب .</p>
		
		<div class="section">
		    <table width="100%">
		    	<tr>
		    		<th width="35%" align="left"><b>PHP تنظيمات</b></th>
		    		<th width="25%" align="left"><b>تنظيمات فعلي</b></th>
		    		<th width="25%" align="left"><b>تنظیمات مورد نیاز</b></th>
		    		<th width="15%" align="center"><b>وضعيت</b></th>
		    	</tr>
		    	<tr>
		    		<td>MySQL:</td>
		    		<td><?php echo extension_loaded('mysql') || extension_loaded('mysqli')
		    					? 'On'
		    					: 'Off'; ?></td>
		    		<td>On</td>
		    		<td align="center"><?php echo extension_loaded('mysql') || extension_loaded('mysqli')
		    									? '<img src="' . $template_dir . 'image/good.png" alt="Good" />'
		    									: '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    	<tr>
		    		<td>GD:</td>
		    		<td><?php echo extension_loaded('gd') ? 'On' : 'Off'; ?></td>
		    		<td>On</td>
		    		<td align="center"><?php echo extension_loaded('gd') ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    	<tr>
		    		<td>CURL:</td>
		    		<td><?php echo extension_loaded('curl') ? 'On' : 'Off'; ?></td>
		    		<td>On</td>
		    		<td align="center"><?php echo extension_loaded('curl') ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    	<tr>
		    		<td>ZIP:</td>
		    		<td><?php echo extension_loaded('zlib') ? 'On' : 'Off'; ?></td>
		    		<td>On</td>
		    		<td align="center"><?php echo extension_loaded('zlib') ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    	<tr>
		    		<td>MultiByte String:</td>
		    		<td><?php echo extension_loaded('mbstring') ? 'On' : 'Off'; ?></td>
		    		<td>On</td>
		    		<td align="center"><?php echo extension_loaded('mbstring') ? '<img src="' . $template_dir . 'image/good.png" alt="Good" />' : '<img src="' . $template_dir . 'image/bad.png" alt="Bad" />'; ?></td>
		    	</tr>
		    </table>
		</div>
		<p>3. لطفا دسترسی برای خواندن و نوشتن و تغییر فایل های زیر را ایجاد کنید.</p>
		
		<div class="section">
		    <table width="100%">
		    	<tr>
		    		<th align="left"><b>ادرس فايل</b></th>
		    		<th width="15%" align="left"><b>وضعيت</b></th>
		    	</tr>
		    	<tr>
		    		<td><?php echo $config_catalog; ?></td>
		    		<td><?php echo is_writable($config_catalog) ? '<span class="good">در دسترس</span>' : '<span class="bad">عدم دسترسي</span>'; ?></td>
		    	</tr>
		    	<?php if (!is_writable($config_catalog)) { ?>
		    	<tr>
		    		<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777 <?php echo $config_catalog; ?></span>
		    		</td>
		    	</tr>
		    	<?php } ?>
		    </table>
		</div>
		<p>4. لطفا دسترسی خواندن و نوشتن پوشه های داخل لیست را ایجاد کنید.</p>
		
		<div class="section">
		    <table width="100%">
		    	<tr>
		    		<th align="left"><b>ادرس فايل/ پوشه موجود در هاست</b></th>
		    		<th width="15%" align="left"><b>وضعيت</b></th>
		    	</tr>
		    	<tr>
		    		<td><?php echo $system; ?></td>
		    		<?php $_writable = is_writable($system) ?>
		    		<td><?php echo $_writable ? '<span class="good">در دسترس</span>' : '<span class="bad">عدم دسترسي</span>'; ?></td>
		    	</tr>
		    	<?php if (!$_writable) { ?>
		    	<tr>
	<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777 <?php echo $system; ?></span>
		    		</td>
		    	</tr>
		    	<?php } else { ?>
		    	<?php if (!is_writable($cache)) { ?>
		    		<tr>
		<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777 <?php echo $cache . '/'; ?></span>
		    			</td>
		    		</tr>
		    		<?php } ?>
		    	<?php if (!is_writable($logs)) { ?>
		    		<tr>
	<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777 <?php echo $logs . '/'; ?></span>
		    			</td>
		    		</tr>
		    		<?php }
		    }?>
		    	<tr>
		    		<td><?php echo $image . '/'; ?></td>
		    		<?php $_writable = is_writable($image) ?>
		    		<td><?php echo $_writable ? '<span class="good">در دسترس</span>' : '<span class="bad">عدم دسترسي</span>'; ?></td>
		    	</tr>
		    	<?php if (!$_writable) { ?>
		    	<tr>
		    		<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777 <?php echo $image . '/'; ?></span>
		    		</td>
		    	</tr>
		    	<?php } else { ?>
		    	<?php if (!is_writable($image_thumbnails)) { ?>
		    		<tr>
		<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777 <?php echo $image_thumbnails . '/'; ?></span>
		    			</td>
		    		</tr>
		    		<?php }
		    }?>
		    	<tr>
		    		<td><?php echo $download . '/'; ?></td>
		    		<td><?php echo is_writable($download) ? '<span class="good">در دسترس</span>' : '<span class="bad">عدم دسترسي</span>'; ?></td>
		    	</tr>
		    	<?php if (!is_writable($download)) { ?>
		    	<tr>
		    		<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777 <?php echo $download . '/'; ?></span>
		    		</td>
		    	</tr>
		    	<?php } ?>
		    	<tr>
		    		<td><?php echo $extensions . '/'; ?></td>
		    		<td><?php echo is_writable($extensions) ? '<span class="good">در دسترس</span>' : '<span class="bad">عدم دسترسي</span>'; ?></td>
		    	</tr>
		    	<?php if (!is_writable($extensions)) { ?>
		    	<tr>
		    		<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777  <?php echo $extensions . '/'; ?></span>
		    		</td>
		    	</tr>
		    	<?php } ?>
		    	<tr>
		    		<td><?php echo $resources . '/'; ?></td>
		    		<td><?php echo is_writable($resources) ? '<span class="good">در دسترس</span>' : '<span class="bad">عدم دسترسي</span>'; ?></td>
		    	</tr>
		    	<?php if (!is_writable($resources)) { ?>
		    	<tr>
		    		<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777  <?php echo $resources . '/'; ?></span>
		    		</td>
		    	</tr>
		    	<?php } ?>
		    	<tr>
		    		<td><?php echo $backup . '/'; ?></td>
		    		<td><?php echo is_writable($backup) ? '<span class="good">در دسترس</span>' : '<span class="bad">عدم دسترسي</span>'; ?></td>
		    	</tr>
		    	<?php if (!is_writable($backup)) { ?>
		    	<tr>
		    		<td colspan="2"><span class="bad">دسترسي پوشه/فايل مورد نظر را جهت نصب بر روي 777 يا 0777 قرار دهيد<br/> permission 0777  <?php echo $backup . '/'; ?></span>
		    		</td>
		    	</tr>
		    	<?php } ?>
		    </table>
		</div>		
	</div>

	<div class="panel-footer">
		<a class="btn btn-default" href="<?php echo $back; ?>"><i class="fa fa-arrow-right"></i> قبلی</a>
		<a class="btn btn-primary pull-left" onclick="document.getElementById('form').submit()">ادامه <i class="fa fa-arrow-left"></i></a>
	</div>
	
	</div>
	</form>
	</div>
	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">
			<h4><i class="fa fa-info-circle fa-fw"></i> ویژگی های آبانته کارت</h4>
			</div>
			<div class="panel-body">
				<h5 class="tip_heading">ويرايش اسان متن ها</h5>
				<p>در مديريت ابانته ميتواند به راحتي اقدام به ويرايش مطالب نماييد</p>
				<h5 class="tip_heading">چند زبانه و ترجمه خودکار</h5>
				<p>فروشگاه ساز ابانته با دارا بودن قابلت نصب چندزبان در محيط كاربري</p>
				<h5 class="tip_heading">ذخيره سريع</h5>
				<p>با اضافه شدن دكمه ذخيره سريع ميتوانيد در هنگام ويرايش اقدام به ذخيره سازي مطالب نماييد</p>
				<h5 class="tip_heading">جستجوي هومشند</h5>
				<p>در قسمت جستجو با واردكردن چند كلمه ليستي از گزينه هارا خواهيد داشت</p>
				<h5 class="tip_heading">مديريت رسانه</h5>
				<p>محيط کاربری مناسب برای مدیریت فایل های رسانه ای </p>
				<h5 class="tip_heading">طرح بندی دلخواه</h5>
				<p>ميتوانيد به اساني چيدمان قسمت هاي مختلف را تغيير دهيد</p>
				<h5 class="tip_heading">وارد كردن و خروجي گرفتن</h5>
				<p>در فروشگاه ابانته به اساني ميتوانيد  از مشتريان و محصولات ليست خروجي تهيه كنيد</p>
			</div>
					
		</div>
	</div>
	
</div>
<?php echo $footer; ?>