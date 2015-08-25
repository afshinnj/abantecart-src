<?php echo $header; ?>
<div class="row">
	<div class="col-md-9">
	<div class="panel panel-default">

	<ul class="nav nav-tabs" role="tablist">
	  <li class="disabled"><a href="#" onclick="return false;">1:مجوز</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">2: بررسي اطلاعات</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">3: پیکربندی</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">4: بارگذاری داده ها</a></li>
	  <li class="active"><a href="#" onclick="return false;">5: پایان</a></li>
	</ul>

	<div class="panel-heading">
	<h2><i class="fa fa-flag-checkered fa-fw"></i> نصب فروشگاه با موفقيت انجام شد!</h2>
	</div>
	
	<div class="panel-body panel-body-nopadding">
	
		<div class="warning alert alert-error alert-danger"><?php echo $message; ?></div>

		<?php if($salt){?>
			<div class="warning alert alert-error alert-danger">
				نكته مهم بعد از نصب فروشگاه ساز.<br>
كد امنيتي زير را در مكاني امن دخيره كنيد.<br>اين كد امنتي فروشگاه در زمان فراموشي رمز عبور فروشگاه مي باشد<br>
				<h3><?php echo $salt; ?></h3></div>
		<?php }  ?>

		<p>فروشگاه شما با موفقيت نصب شد. هم اكنون ميتوانيد با رفتن به محيط كاربري و يا محيط مديريت فروشگاه از امكانات ان استفاده نماييد.</p>
		<p>با تشكر از انتخاب شما در استفاده از فروشگاه ساز ابانته.</p> 
		<p>نظرات و پيشنهادات خودتان را ميتوانيد براي ما ارسال نماييد.</p>
		<p class="text-center">
			<i class="fa fa-home fa-fw"></i> <a href="http://www.abantecart.com" target="_abante"> فروشگاه ساز ابانته</a>&nbsp;&nbsp;
			<i class="fa fa-graduation-cap fa-fw"></i> <a href="http://www.abantecart.com/ecommerce-documentation" target="_blank">اموزش ها</a>&nbsp;&nbsp;
			<i class="fa fa-puzzle-piece fa-fw"></i> <a href="http://marketplace.abantecart.com" target="_blank">فروشگاه ماژول و قالب ها</a>&nbsp;&nbsp;
		<i class="fa fa-comments fa-fw"></i> <a href="http://forum.abantecart.com" target="_abante">انجمن پشتيباني</a></p>

		<div class="container-fluid text-center">
		  <p>جهت حمايت  مالي از تيم فارسي سازي ابانته هم اكنون ميتوانيد اقدان كنيد. </p> 
		</div>

		<div class="container-fluid">
	    <div class="snapshots col-md-6">
		    <a href="../"><img src="<?php echo $template_dir; ?>image/storefront.png" alt="" width="250" style="border: none;" /></a><br />
		    <a href="../">ورود به محيط كاربري</a>
		</div>
	    <div class="snapshots col-md-6">
		    <a href="../<?php echo $admin_path ?>"><img src="<?php echo $template_dir; ?>image/admin.png" alt="" width="250" style="border: none;" /></a><br />
		    <a href="../<?php echo $admin_path ?>">ورود به پنل مديريت فروشگاه</a>
		</div>
		</div>

		</br>
		</br>
		</br>
		</br>

		<div class="container-fluid">
			<div class="h4 heading col-md-12 text-center" style="min-height: 50px;">نصب ماژول هاي كاربري</div>
		    <div class="snapshots col-md-6">
			    <?php $url = '../'.$admin_path."&rt=extension/extensions/install&extension=default_stripe"; ?>
			    <a href="<?php echo $url;?>"><img src="../extensions/default_stripe/image/icon.png" alt="Install Stripe Payment" style="border: none;" /></a><br />
			    <a href="<?php echo $url;?>">Stripe</a>
			</div>
		    <div class="snapshots col-md-6">
			    <?php $url = '../'.$admin_path."&rt=extension/extensions/install&extension=default_pp_standart"; ?>
			    <a href="<?php echo $url;?>"><img src="../extensions/default_pp_standart/image/icon.png" alt="Install Paypal Standart Payment" style="border: none;" /></a><br />
			    <a href="<?php echo $url;?>">Paypal</a>
			</div>
		</div>

	</div>
		
	</div>
	
	</div>
	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-body text-center">
				<div class="social_icon">
			<a href="https://www.facebook.com/AbanteCart" target="_new"><i class="fa fa-thumbs-o-up fa-4x"></i></a>
				</div>
				<h4><a href="https://www.facebook.com/AbanteCart" target="_new">ابانته كارت در فيسبوك</a></h4>

				<div class="social_icon">
				<a href="https://twitter.com/abantecart" target="_new"><i class="fa fa-twitter fa-4x"></i></a>
				</div>
				<h4><a href="https://twitter.com/abantecart" target="_new">ابانته كارت در تويتر</a></h4>

				<div class="social_icon">
				<a href="https://marketplace.abantecart.com/index.php?rt=account%2Fsubscriber" target="_new"><i class="fa fa-newspaper-o fa-4x"></i></a>
				</div>
				<h4><a href="https://twitter.com/abantecart" target="_new">خبرها ي بروزرساني</a></h4>

				<div class="social_icon">
				<a href="http://forum.abantecart.com" target="_new"><i class="fa fa-comments fa-4x"></i></a>
				</div>
				<h4><a href="http://forum.abantecart.com" target="_new">انجمن پشتيباني</a></h4>

				<div class="social_icon">
				<a href="http://www.abantecart.com/partners" target="_new"><i class="fa fa-group fa-4x"></i></a>
				</div>
				<h4><a href="http://www.abantecart.com/partners" target="_new">گروه سفارشي سازي</a></h4>

				<div class="social_icon">
				<a href="https://github.com/abantecart/abantecart-src" target="_new"><i class="fa fa-github fa-4x"></i></a>
				</div>
				<h4><a href="https://github.com/abantecart/abantecart-src" target="_new">ادرس github</a></h4>
				
			</div>
		</div>
	</div>
	
</div>
<?php echo $footer; ?>