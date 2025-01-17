<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>

<div id="content" class="panel panel-default">

	<div class="panel-heading col-xs-12">
		<div class="primary_content_actions pull-right">
			<div class="actionitem btn-group mr10 toolbar">
				<a class="btn btn-primary lock-on-click tooltips" href="<?php echo $insert; ?>" title="<?php echo $button_add; ?>">
				<i class="fa fa-plus"></i>
				</a>
			</div>
		</div>

		<?php include($tpl_common_dir . 'content_buttons.tpl'); ?>	
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
		<?php echo $listing_grid; ?>
	</div>

</div>

<script type="text/javascript">

	var grid_ready = function(data) {
		var url = '<?php echo $embed_url?>';
		$('#manufacturer_grid tr[role="row"]').each(function () {
			if ($(this).attr('id')) {
				url += '&manufacturer_id[]=' + $(this).attr('id');
			}
		});
		$('a[data-target="#embed_modal"]').attr('href', url);
	}
</script>