<?php
defined('BASEPATH') or exit('Not Allowed Direct Access');

class Mahasiswa extends CI_Controller{

    public function __construct()
    {
        parent:: __construct();
        $this->load->model('mahasiswa_model');
    }

    public function index(){
        $mahasiswa = $this->mahasiswa_model->getdata();

        echo "<pre>";
        print_r($mahasiswa);

        echo "</pre>";
    }
}


?>