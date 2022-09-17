<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Barang extends CI_Controller {

	public function __construct(){
        parent:: __construct();
        $this->load->model('barang_model');
    }


    public function index() {
		

        $this->data['title'] = 'Barang';
        $this->data['barang'] = $this->barang_model->getDataBarang();

		$this->load->view('barang/barang_list', $this->data);
	}

    public function add(){
        $this->data['little'] = ' Tambah Barang';
        $this->load->view('barang/barang_add', $this->data);
    }
}
?>