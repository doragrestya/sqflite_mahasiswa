<?php

  defined('BASEPATH') OR exit('No Script Direct');

  class Api extends CI_Controller{
  	function __construct(){
  		parent:: __construct();
  		date_default_timezone_set('Asia/Jakarta');
  		error_reporting(E_ALL);
  		ini_set('Display Error', 1);
  	}

  	function registerUser(){
      		$namefull = $this->input->post('name');
      		$email = $this->input->post('email');
      		$password = $this->input->post('password');

      		$this->db->where('email_user', $email);
      		$q = $this->db->get('tb_user');

      		if($q -> num_rows() > 0){
      			$data['status'] = 404;
      			$data['message'] = "Email telah terdaftar";
      		} else {
      			$save['fullname_user'] = $namefull;
      			$save['email_user'] = $email;
      			$save['password_user'] = md5($password);

      			$querySaved = $this->db->insert('tb_user', $save);

      			if ($querySaved) {
      				$data['status'] = 200;
      				$data['message'] = 'Successfully Register';
      			} else {
      				$data['status'] = 404;
      				$data['message'] = 'Failed Register';
      			}
      		}
      		echo json_encode($data);
      	}

      	function loginUser(){
      		$email = $this->input->post('email');
      		$password = $this->input->post('password');

      		$this->db->where('email_user', $email);
      		$this->db->where('password_user', md5($password));

      		$q = $this->db->get('tb_user');

      		if($q -> num_rows() > 0){
      			$data['status'] = 200;
      			$data['message'] = 'Successfully Login User';
      			$data['user'] = $q->result();
      		} else {
      			$data['status'] = 404;
      			$data['message'] = 'Failed Login User';
      		}
      		echo json_encode($data);
      	}



  }
?>