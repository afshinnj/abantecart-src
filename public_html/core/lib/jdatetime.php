<?php

/*
 * persian date 
 * 
 * www.abantecart.ir
 * 
 * afshin nj
 */
if (!defined('DIR_CORE')) {
    header('Location: static_pages/');
}

class Jdate {

    public static function now() {

        $date = new jDateTime(true, true, 'Asia/Tehran');
        return $date->date("Y-m-d H:i:s", false, false);
    }

    public static function defualt() {

        $date = new jDateTime(true, true, 'Asia/Tehran');
        return $date->date("d/m/Y", false, false);
    }

    public static function toJalali() {
        $date = new jDateTime(true, true, 'Asia/Tehran');
        $d = date('Y-m-d', strtotime('-7 day'));
        $exp = explode('-', $d);
        $result = $date->toJalali($exp[0], $exp[1], $exp[2]);
        if($result[1] <= 9){
            $_d = '0' . $result[1];
        }  else {
            $_d = $result[1];
        }
        
        if($result[2] <= 9){
            $_m = '0' . $result[2];
        }  else {
            $_m = $result[2];
        }        
        return $result[0] . '-' . $_d . '-' . $_m;
    }

    public static function date() {
        
        $date = new jDateTime(true, true, 'Asia/Tehran');
        return $date->date("Y-m-d", false, false);
        
    }

  /*  public static function trash($minus = NULL) {

        $date = new jDateTime(true, true, 'Asia/Tehran');

        if ($minus == NULL) {
            return $date->date("Y-m-d", false, false);
        } else {
            $y = $date->date('Y', false, false);
            $m = $date->date('m', false, false);
            $d = $date->date('d', false, false);

            $j_days_in_month = array(0, 31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29);

            $mmm = ceil($minus / 7);

            if ($minus > $j_days_in_month[str_replace('0', '', $m)]) {
                $minus_month = $m - ceil($mmm / 4);
                if ($minus_month <= 9) {
                    $month = '0' . $minus_month;
                }
            }

            $minus_day = $d - $minus;
            if ($minus_day < 0) {
                $minus_month = $m - 1;

                if ($minus_month <= 9) {
                    $month = '0' . $minus_month;
                }

                $day = $j_days_in_month[$minus_month] - str_replace('-', '', $minus_day);

                //return $date->date("Y", false, false) . '-' . $month . '-' . $day;
            } else {
                if ($minus_day <= 9) {
                    $day = '0' . $minus_day;
                    //return $date->date("Y-m-$day", false, false);
                } else {
                    //return $date->date("Y-m-$minus_day", false, false);
                }
            }
        }
    }*/

}
