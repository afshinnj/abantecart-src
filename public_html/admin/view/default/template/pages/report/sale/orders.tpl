<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>

<div id="content" class="panel panel-default">

	<div class="panel-heading col-xs-12">
		<div class="primary_content_actions pull-right">
			<div class="btn-group mr10 toolbar">
				<?php
				if (!empty($search_form)) {
					?>
					<form id="<?php echo $search_form['form_open']->name; ?>"
						  method="<?php echo $search_form['form_open']->method; ?>"
						  name="<?php echo $search_form['form_open']->name; ?>" class="form-inline" role="form">

						<?php
						foreach ($search_form['fields'] as $f) {
							?>
							<div class="form-group">
								<div class="input-group input-group-sm">
									<?php echo $f; ?>
								</div>
							</div>
						<?php
						}
						?>
				    	<div class="form-group">
				    		<button type="submit" class="btn btn-xs btn-primary tooltips" title="<?php echo $button_filter; ?>">
				    			<?php echo $search_form['submit']->text ?>
				    		</button>
				    		<button type="reset" class="btn btn-xs btn-default tooltips" title="<?php echo $button_reset; ?>">
				    			<i class="fa fa-refresh"></i>
				    		</button>
	
				    	</div>
					</form>
				<?php
				}
				?>
			</div>
		</div>

		<?php include($tpl_common_dir . 'content_buttons.tpl'); ?>	
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
		<?php echo $listing_grid; ?>
	</div>

</div>
<script type="text/javascript" src="<?php echo $template_dir; ?>javascript/persian-datepicker/js/persian-date.js"></script>
<script type="text/javascript" src="<?php echo $template_dir; ?>javascript/persian-datepicker/js/persian-datepicker-0.4.5.min.js"></script>
<link rel="stylesheet" type="text/css" href="<?php echo $template_dir; ?>javascript/persian-datepicker/css/persian-datepicker-0.4.5.css" />
<script type="text/javascript"><!--
$(document).ready(function() {

	$(function() {
            $("#report_sales_grid_search_date_start, #report_sales_grid_search_date_end").persianDatepicker({

                format: 'DD/MM/YYYY'

            });
           });    
});
//--></script>