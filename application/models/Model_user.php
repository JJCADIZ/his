<?php
  if (!defined('BASEPATH'))exit('No direct script access allowed');
  class Model_user extends CI_Model{
    function get_tasks($type_id)
    {
      $this->db->select('*');
      $this->db->from('task_usertype tu');
      $this->db->join('task t','tu.task_id=t.task_id','left');
      $this->db->where('user_type_id',$type_id);
      $query = $this->db->get();
      return $query->result_array();
    }

    function get_permissions($type_id)
    {
      $where = "user_type_id ='$type_id' and access='1'";
      $this->db->select('*');
      $this->db->from('permission_usertype pu');
      $this->db->join('permission p','pu.permission_id=p.permission_id','left');
      $this->db->where($where);
      $query = $this->db->get();
      return $query->result_array();
    }

    function fetch_count_all_patients(){
      $this->db->select('*');
      $this->db->from('patient');
      $query = $this->db->get();
      return $query->num_rows();
    }

    function fetch_count_all_nurse(){
      $this->db->select('*');
      $this->db->from('users');
      $this->db->where('type_id', 3);
      $query = $this->db->get();
      return $query->num_rows();
    }


  }
?>
