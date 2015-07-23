<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class Jdate {

    public static function now() {
        
        $date = new jDateTime(true, true, 'Asia/Tehran');
        
       return $date->date("Y-m-d H:i:s", false, false);
    }

}
