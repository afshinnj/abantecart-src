<?php echo $header; ?>
<div class="row">
	<div class="col-md-9">
	<div class="panel panel-default">

	<ul class="nav nav-tabs" role="tablist">
	  <li class="disabled"><a href="#" onclick="return false;">1: مجوز</a></li>
	  <li class="disabled"><a href="<?php echo $back; ?>">2: اعتبار سنجی سازگاری</a></li>
	  <li class="active"><a href="#" onclick="return false;">3: پیکربندی</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">4: بارگذاری داده ها</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">5: پایان</a></li>
	</ul>

	<div class="panel-heading">
	<h2><i class="fa fa-gear fa-fw"></i> پيكربندي <small>تنظيم اطلاعات پايگاه داده</small></h2>
	</div>
	
	<div class="panel-body panel-body-nopadding">
		<form class="form-horizontal" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

		<?php if ($error['warning']) { ?>
		<div class="warning alert alert-error alert-danger"><?php echo $error['warning']; ?></div>
		<?php } ?>

		<label class="h5 heading">1. لطفا جزئیات پایگاه داده اتصال خود را وارد کنید.</label>

		<div class="form-group <?php if (!empty($error['db_driver'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">نوع پايگاه داده:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['db_driver']; ?>
			</div>
			<?php if (!empty($error['db_driver'])) { ?>
				<span class="help-block field_err"><?php echo $error['db_driver']; ?></span>
			<?php } ?>
		</div>

		<div class="form-group <?php if (!empty($error['db_host'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">
نام میزبان پایگاه داده:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['db_host']; ?>
			</div>
			<?php if (!empty($error['db_host'])) { ?>
				<span class="help-block field_err"><?php echo $error['db_host']; ?></span>
			<?php } ?>
		</div>

		<div class="form-group <?php if (!empty($error['db_user'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">نام كاربري پايگاه داده:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['db_user']; ?>
			</div>
			<?php if (!empty($error['db_user'])) { ?>
				<span class="help-block field_err"><?php echo $error['db_user']; ?></span>
			<?php } ?>
		</div>

		<div class="form-group <?php if (!empty($error['db_password'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">پسورد پايگاه داده:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['db_password']; ?>
			</div>
			<?php if (!empty($error['db_password'])) { ?>
				<span class="help-block field_err"><?php echo $error['db_password']; ?></span>
			<?php } ?>
		</div>

		<div class="form-group <?php if (!empty($error['db_name'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">نام پايگاه داده:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['db_name']; ?>
			</div>
			<?php if (!empty($error['db_name'])) { ?>
				<span class="help-block field_err"><?php echo $error['db_name']; ?></span>
			<?php } ?>
		</div>

		<div class="form-group <?php if (!empty($error['db_prefix'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">پسوند جداول:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['db_prefix']; ?>
			</div>
			<?php if (!empty($error['db_prefix'])) { ?>
				<span class="help-block field_err"><?php echo $error['db_prefix']; ?></span>
			<?php } ?>
		</div>


<label class="h5 heading">2.لطفا يك نام انگليسي براي قسمت مديريت وارد كنيد. مثال:admin</label>
		
		<div class="form-group <?php if (!empty($error['admin_path'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">نام قسمت مديريت:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['admin_path']; ?>
			</div>
			<?php if (!empty($error['admin_path'])) { ?>
				<span class="help-block field_err"><?php echo $error['admin_path']; ?></span>
			<?php } ?>
		</div>
					
		<label class="h5 heading">3.لطفا نام كاربري و رمز عبور مديريت را وارد نماييد</label>

		<div class="form-group <?php if (!empty($error['username'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">نام كاربري مديريت:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['username']; ?>
			</div>
			<?php if (!empty($error['username'])) { ?>
				<span class="help-block field_err"><?php echo $error['username']; ?></span>
			<?php } ?>
		</div>

		<div class="form-group <?php if (!empty($error['password'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">رمز عبور مديريت:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['password']; ?>
			</div>
			<?php if (!empty($error['password'])) { ?>
				<span class="help-block field_err"><?php echo $error['password']; ?></span>
			<?php } ?>
		</div>

		<div class="form-group <?php if (!empty($error['password_confirm'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">تكرار رمز عبور:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['password_confirm']; ?>
			</div>
			<?php if (!empty($error['password_confirm'])) { ?>
				<span class="help-block field_err"><?php echo $error['password_confirm']; ?></span>
			<?php } ?>
		</div>

		<div class="form-group <?php if (!empty($error['email'])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-4 col-xs-12">ايميل مديريت:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<?php echo $form['email']; ?>
			</div>
			<?php if (!empty($error['email'])) { ?>
				<span class="help-block field_err"><?php echo $error['email']; ?></span>
			<?php } ?>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-4 col-xs-12">نصب اطلاعات نمايشي فروشگاه:</label>
			<div class="input-group col-sm-6 col-xs-12 afield">
				<input type="checkbox" id="load_demo_data" name="load_demo_data" checked="checked">
			</div>
		</div>

		</form>
				
	</div>
	
	<div class="panel-footer">
		<a class="btn btn-default" href="<?php echo $back; ?>"><i class="fa fa-arrow-right"></i> برگشت</a>
	<a class="btn btn-primary pull-left" onclick="document.getElementById('form').submit()">ادامه <i class="fa fa-arrow-left"></i></a>
	</div>
	
	</div>
	
	</div>
	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">
			<h4><i class="fa fa-info-circle fa-fw"></i> ويژگي هاي فروشگاه ساز ابانته</h4>
			</div>
			<div class="panel-body">
				<h5 class="tip_heading">فروشگاه همراه</h5>
				<p>قابلت نمايش فروشگاه بر روي انواع گوشي هاي هوشمند</p>
				<h5 class="tip_heading">IOS و Android سيستم هاي</h5>
				<p>قابلت نمايش در گوشهاي داراي سيستم عامل اندرويد وios.</p>
				<h5 class="tip_heading">اپديت اسان</h5>
				<p>اپديت اسان با استفاده از گزينه اپديت بعد از دريافت اطلاع رساني موجود بودن نسخه جديد</p>
				<h5 class="tip_heading">ويژگي هاي ديگر</h5>
				<p>با توجه به گسترس دنياي نت و همينطور نياز كاربراني كه از ابانته استفاده ميكند در طي روزهاي مختلف ماژول هاي جديدي ارائه خواهد شد</p>
				<h5 class="tip_heading">سفارش سازي فروشگاه</h5>
				<p>تيم پشتيباني با داشتن كادر گروه مجرب اماده سفارشي سازي فروشگاه بر طبق نياز و سليقه كاربران مي باشد.</p>
			</div>
					
		</div>
	</div>
	
</div>
<?php echo $footer; ?>