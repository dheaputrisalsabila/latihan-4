<?php
defined('BASEPATH') OR exit('Not allowed acces');

class Barang_model extends CI_Model{

    public function getDataBarang(){
        $data = $this->db->get('barang')->result();
        return $data;
    }
}
?>