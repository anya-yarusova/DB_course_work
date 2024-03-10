package com.annyarusova.russiantrip.repository;

import com.annyarusova.russiantrip.entity.CommentEntity;

import org.springframework.data.jpa.repository.JpaRepository;


public interface CommentRepository extends JpaRepository<CommentEntity, Integer> {

}
