<?php
defined('BASEPATH') or exit('Not Allowed Acces');

class Mahasiswa_model extends CI_Model{

    public function __construct()
    {
        parent:: __construct();
        $this->db2 = $this->load->database('kampus',TRUE);
    }

    public function getdata(){
        $data = $this->db2->get('mahasiswa')->result();
        return $data;
    }
}


?>