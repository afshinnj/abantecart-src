<?php echo $header; ?>
<div class="row">
	<div class="col-md-9">
	<div class="panel panel-default">

	<ul class="nav nav-tabs" role="tablist">
	  <li class="active"><a href="#">1: مجوز</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">2: اعتبار سنجی سازگاری</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">3: پیکربندی</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">4: بارگذاری داده ها</a></li>
	  <li class="disabled"><a href="#" onclick="return false;">5: پایان</a></li>
	</ul>

	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	<div class="panel-heading">
	<h2><i class="fa fa-legal fa-fw"></i> مجوز  <small>لطفا توافقنامه زیر را بررسی کنید </small> </h2>
	</div>
	
	<div class="panel-body">

		<?php if ($error_warning) { ?>
		<div class="warning alert alert-error alert-danger"><?php echo $error_warning; ?></div>
		<?php } ?>
	
                <div class="license_text" dir="ltr"><?php echo $text; ?></div>
				
	</div>
	
	<div class="panel-footer">
		<div class="form-inline form-group">
			<input type="checkbox" id="form_agree" name="agree">
			<label for="form_agree">من توافقنامه را قبول میکنم</label>
			<a class="btn btn-primary pull-left" onclick="document.getElementById('form').submit()">ادامه <i class="fa fa-arrow-left"></i></a>
		</div>
	</div>
	
	</div>
	</form>
	</div>
	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">
			<h4><i class="fa fa-info-circle fa-fw"></i> ویژگی های آبانته کارت </h4>
			</div>
                    <div class="panel-body" style="text-align: justify">
				<h5 class="tip_heading">کاملا رایگان</h5>
				<p>آبانته کارت را میتوانید رایگان استفاده کنید و تغییرات را مطابق با <a onclick="window.open('http://www.opensource.org/licenses/OSL-3.0');">OSL 3.0</a> انجام دهید </p>
				<h5 class="tip_heading">تجارت الکترونیک قدرتمند</h5>
				<p>با ابزار و ویژگی های آبانته کارت میتوانید کسب کار الکترونکی قوی و راحتی ایجاد کنید</p>
				<h5 class="tip_heading">راه حل امن</h5>
				<p>اقدامات گسترده در توسعه مطابق با استانداردهای PCI و دیگر اعمال می شود</p>
				<h5 class="tip_heading">سریع و کارآمد</h5>
				<p>پایگاه داده ها و کد های بهینه سازی شده این امکان را به ما میدهند تا بتوانیم به راحتی در سایت های پر ترافیک و سنگین را اجرا کنیم </p>
				<h5 class="tip_heading">انعطاف پذیر و قابل ارتقا</h5>
				<p>معماری انعطاف پذیر و وجود API ها اجازه میدهند تا توسعه و نگهداری سری و ارزانی داشته باشیم</p>
			</div>
					
		</div>
	</div>
	
</div>
<?php echo $footer; ?>