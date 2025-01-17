<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $language; ?>" xml:lang="<?php echo $language; ?>">
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/invoice.css" />
</head>
<body>
<?php foreach ($orders as $order) { ?>
<div style="page-break-after: always;">
  <h1><?php echo $text_invoice; ?></h1>
  <div class="div1">
    <table width="100%">
      <tr>
        <td><?php echo $order['store_name']; ?><br />
          <?php echo $order['address']; ?><br />
          <?php if ($order['telephone']) { ?>
          <?php echo $text_telephone; ?> <?php echo $order['telephone']; ?><br />
          <?php } ?>          
          <?php if ($order['fax']) { ?>
          <?php echo $text_fax; ?> <?php echo $order['fax']; ?><br />
          <?php } ?>
          <?php echo $order['email']; ?><br />
          <?php echo $order['store_url']; ?></td>
        <td align="right" valign="top"><table>
            <tr>
              <td><b><?php echo $text_invoice_date; ?></b></td>
              <td><?php echo $order['date_added']; ?></td>
            </tr>
            <tr>
              <td><b><?php echo $text_invoice_no; ?></b></td>
              <td><?php echo $order['order_id']; ?></td>
            </tr>
          </table></td>
      </tr>
    </table>
  </div>
 
  <table class="address">
    <tr class="heading">
      <td width="50%"><b><?php echo $text_to; ?></b></td>
      <td width="50%"><b><?php echo $text_ship_to; ?></b></td>
    </tr>
    <tr>
      <td><?php echo $order['payment_address']; ?><br/><?php echo $order['customer_email']; ?></td>
      <td><?php echo$order['shipping_address']; ?></td>
    </tr>
  </table>
  <table class="product">
    <tr class="heading">
      <td><b><?php echo $column_product; ?></b></td>
      <td><b><?php echo $column_model; ?></b></td>
      <td align="right"><b><?php echo $column_quantity; ?></b></td>
      <td align="right"><b><?php echo $column_price; ?></b></td>
      <td align="right"><b><?php echo $column_total; ?></b></td>
    </tr>
    <?php foreach ($order['product'] as $product) { ?>
    <tr>
      <td><?php echo $product['name']; ?>
        <?php foreach ($product['option'] as $option) { ?>
        <br />
        &nbsp;<small> - <?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
        <?php } ?></td>
      <td><?php echo $product['model']; ?></td>
      <td align="right"><?php echo $product['quantity']; ?></td>
      <td align="right"><?php echo $product['price']; ?></td>
      <td align="right"><?php echo $product['total']; ?></td>
    </tr>
    <?php } ?>
    <?php foreach ($order['total'] as $total) { ?>
    <tr>
      <td align="right" colspan="4"><b><?php echo $total['title']; ?></b></td>
      <td align="right"><?php echo $total['text']; ?></td>
    </tr>
    <?php } ?>
  </table>
</div>
<?php } ?>
</body>
</html>