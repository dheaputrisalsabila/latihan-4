<?php
defined('BASEPATH') OR exit('No direct script access allowed');
$this->load->view('dist/_partials/header');
?>
      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>Data Barang</h1>
            <div class="section-header-breadcrumb">
              <div class="breadcrumb-item active"><a href="#">Dashboard</a></div>
              <div class="breadcrumb-item"><a href="#">Modules</a></div>
              <div class="breadcrumb-item">Barang</div>
            </div>
          </div>

          <div class="section-body">
           

            <div class="row">
              <div class="col-12">
                <div class="card">
                  <div class="card-header">
                    <h4>List Daftar Barang</h4>
                  </div>
                  <div class="card-body">
                  <a href="" class="btn btn-primary">Tambah Data</a>
                  </div>  
                
                  <div class="card-body">
                    <div class="table-responsive">
                      <table class="table table-striped" id="table-1">
                        <thead>                                 
                          <tr>
                          
                            <th>Nama Barang</th>
                            <th>Harga Satuan</th>
                            <th>Action</th>
                            
                          </tr>
                        </thead>
                        <tbody>                                 
                            <?php foreach ($barang as $row): ?>
                                <tr>
                                    <td><?= $row->nama_barang; ?></td>
                                    <td><?= $row->harga_satuan; ?></td>
                                    <td>
                                        <a href="" class="btn btn-warning">Edit</a>
                                        <a href="" class="btn btn-danger">Hapuas</a>
                                    </td>
                                        
                                       

                                </tr> 
                                <?php endforeach; ?>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
           
          </div>
        </section>
      </div>
<?php $this->load->view('dist/_partials/footer'); ?>