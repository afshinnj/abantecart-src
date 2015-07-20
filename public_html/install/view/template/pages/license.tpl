<?php echo $header; ?>
<div class="row">

    <div class="col-md-9">
        <div class="panel panel-default">

            <ul class="nav nav-tabs rtl" role="tablist">
                <li class="active"><a href="#">1: پروانه</a></li> <!--License-->
                <li class="disabled"><a href="#" onclick="return false;">2: اعتبار سنجی سازگاری</a></li> <!--Compatibility Validation-->
                <li class="disabled"><a href="#" onclick="return false;">3: پیکر بندی</a></li><!--Configuration-->
                <li class="disabled"><a href="#" onclick="return false;">4: بارگیری داده</a></li><!--Data Load-->
                <li class="disabled"><a href="#" onclick="return false;">5: پایان</a></li><!--Finished-->
            </ul>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div class="panel-heading">
                    <h2><i class="fa fa-legal fa-fw"></i> پروانه <small>لطفا توافقنامه مجوز بررسی</small></h2><!--License--><!--Please review below license agreement-->
                </div>

                <div class="panel-body">

                    <?php if ($error_warning) { ?>
                    <div class="warning alert alert-error alert-danger"><?php echo $error_warning; ?></div>
                    <?php } ?>

                    <div class="license_text"><?php echo $text; ?></div>

                </div>

                <div class="panel-footer">
                    <div class="form-inline form-group">
                        <input type="checkbox" id="form_agree" name="agree">
                        <label for="form_agree">من با مجوز موافق</label><!--I agree to the license-->
                        <a class="btn btn-primary pull-left" onclick="document.getElementById('form').submit()">ادامه <i class="fa fa-arrow-left"></i></a><!--Continue-->
                    </div>
                </div>

        </div>
        </form>
    </div>

    <div class="col-md-3">
        <div class="panel panel-default rtl">
            <div class="panel-heading">
                <h4><i class="fa fa-info-circle fa-fw"></i>نکات آبانته کارت</h4> <!--AbanteCart Tips-->
            </div>
            <div class="panel-body">
                <h5 class="tip_heading">کاملا رایگان</h5><!--Completely free-->
                <p>آبانته کارت کاملا رایگان برای استفاده و تغییر تا زمانی که تغییرات مطابق با است <a onclick="window.open('http://www.opensource.org/licenses/OSL-3.0');">OSL 3.0</a> </p><!--AbanteCart is completely free to use and modify as long as modifications comply with-->
                <h5 class="tip_heading">قدرت گرفته از ecommerce </h5><!--Powerful ecommerce-->
                <p>Loaded with many enterprise grade features and tools</p>
                <h5 class="tip_heading">Secure solution</h5>
                <p>Extended measures are applied in development to comply with PCI and other standards</p>
                <h5 class="tip_heading">Fast and Efficient</h5>
                <p>Database and code well designed and optimized to run fast for heavy traffic sites</p>
                <h5 class="tip_heading">Flexible and Expandable</h5>
                <p>Flexible architecture and extension API allows fast and inexpensive expansion</p>
            </div>

        </div>
    </div>
</div>
<?php echo $footer; ?>
