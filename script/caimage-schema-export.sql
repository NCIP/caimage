/*L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L*/

drop table annotation cascade constraints;
drop table annotation_diagnosis cascade constraints;
drop table annotation_organ cascade constraints;
drop table annotation_publication cascade constraints;
drop table catalog cascade constraints;
drop table coordinate cascade constraints;
drop table curation cascade constraints;
drop table diagnosis cascade constraints;
drop table image cascade constraints;
drop table image_annotation cascade constraints;
drop table image_region_of_interest cascade constraints;
drop table organ cascade constraints;
drop table publication cascade constraints;
drop table region_of_interest cascade constraints;
drop table region_of_interest_annotation cascade constraints;
drop table sex_distribution cascade constraints;
drop table stain cascade constraints;
drop table taxon cascade constraints;
drop table taxon_image cascade constraints;
drop sequence hibernate_sequence;
create table annotation (
   annotation_id number(19,0) not null,
   annotation_description varchar2(255),
   primary key (annotation_id)
);
create table annotation_diagnosis (
   diagnosis_id number(19,0) not null,
   annotation_id number(19,0),
   primary key (diagnosis_id)
);
create table annotation_organ (
   organ_id number(19,0) not null,
   annotation_id number(19,0),
   primary key (organ_id)
);
create table annotation_publication (
   publication_id number(19,0) not null,
   annotation_id number(19,0),
   primary key (publication_id)
);
create table catalog (
   catalog_id number(19,0) not null,
   catalog_name varchar2(255),
   catalog_description varchar2(255),
   catalog_directory varchar2(255),
   primary key (catalog_id)
);
create table coordinate (
   coordinate_id number(19,0) not null,
   domain_x number(10,0),
   domain_y number(10,0),
   domain_z number(10,0),
   primary key (coordinate_id)
);
create table curation (
   curation_id number(19,0) not null,
   curation_type varchar2(255),
   primary key (curation_id)
);
create table diagnosis (
   diagnosis_id number(19,0) not null,
   diagnosis varchar2(255),
   primary key (diagnosis_id)
);
create table image (
   image_id number(19,0) not null,
   image_type varchar2(255) not null,
   image_name varchar2(255),
   image_location varchar2(255),
   image_size number(19,0),
   image_format varchar2(255),
   image_modality varchar2(255),
   image_height number(19,0),
   image_width number(19,0),
   image_depth number(19,0),
   gender_id number(19,0) unique,
   stain_id number(19,0) unique,
   catalog_id number(19,0) unique,
   curation_id number(19,0) unique,
   optical_anesthesia_gas number(10,0),
   optical_anesthesia_inject varchar2(255),
   optical_animal_tissue varchar2(255),
   optical_wave_length number(19,0),
   optical_fluroescent number(19,0),
   optical_bioluminescent varchar2(255),
   optical_reporter_gene varchar2(255),
   optical_confocal varchar2(255),
   optical_two_photon varchar2(255),
   optical_multi_photon varchar2(255),
   optical_oct varchar2(255),
   primary key (image_id)
);
create table image_annotation (
   annotation_id number(19,0) not null,
   image_id number(19,0),
   primary key (annotation_id)
);
create table image_region_of_interest (
   region_of_interest_id number(19,0) not null,
   image_id number(19,0),
   primary key (region_of_interest_id)
);
create table organ (
   organ_id number(19,0) not null,
   organ_name varchar2(255),
   primary key (organ_id)
);
create table publication (
   publication_id number(19,0) not null,
   publication_name varchar2(255),
   primary key (publication_id)
);
create table region_of_interest (
   region_of_interest_id number(19,0) not null,
   roi_description varchar2(255),
   roi_width number(19,0),
   roi_height number(19,0),
   roi_depth number(19,0),
   roi_modality number(19,0),
   roi_magnification number(19,0),
   roi_organ number(19,0),
   roi_diagnosis number(19,0),
   coordinate_id number(19,0) unique,
   primary key (region_of_interest_id)
);
create table region_of_interest_annotation (
   annotation_id number(19,0) not null,
   region_of_interest_id number(19,0),
   primary key (annotation_id)
);
create table sex_distribution (
   gender_id number(19,0) not null,
   gender_description varchar2(255),
   primary key (gender_id)
);
create table stain (
   stain_id number(19,0) not null,
   stain_name varchar2(255),
   stain_description varchar2(255),
   primary key (stain_id)
);
create table taxon (
   species_id number(19,0) not null,
   species_name varchar2(255),
   strain_id number(19,0),
   strain_name varchar2(255),
   primary key (species_id)
);
create table taxon_image (
   image_id number(19,0) not null,
   species_id number(19,0),
   primary key (image_id)
);
alter table annotation_diagnosis add constraint FK413CA1E15A2EE538 foreign key (annotation_id) references annotation;
alter table annotation_diagnosis add constraint FK413CA1E12FED967C foreign key (diagnosis_id) references diagnosis;
alter table annotation_organ add constraint FK632681015A2EE538 foreign key (annotation_id) references annotation;
alter table annotation_organ add constraint FK63268101F91D437C foreign key (organ_id) references organ;
alter table annotation_publication add constraint FKD07D9D1CBAB4F81C foreign key (publication_id) references publication;
alter table annotation_publication add constraint FKD07D9D1C5A2EE538 foreign key (annotation_id) references annotation;
alter table image add constraint FK5FAA95B87ADD5FC foreign key (catalog_id) references catalog;
alter table image add constraint FK5FAA95BB826F645 foreign key (gender_id) references sex_distribution;
alter table image add constraint FK5FAA95B17438EF8 foreign key (curation_id) references curation;
alter table image add constraint FK5FAA95BF8DB46FC foreign key (stain_id) references stain;
alter table image_annotation add constraint FK4045C0937713873C foreign key (image_id) references image;
alter table image_annotation add constraint FK4045C0935A2EE538 foreign key (annotation_id) references annotation;
alter table image_region_of_interest add constraint FKFDEB552B7713873C foreign key (image_id) references image;
alter table image_region_of_interest add constraint FKFDEB552B8158B026 foreign key (region_of_interest_id) references region_of_interest;
alter table region_of_interest add constraint FK4ADF23C7C92BD498 foreign key (coordinate_id) references coordinate;
alter table region_of_interest_annotation add constraint FKACA2CAA78158B026 foreign key (region_of_interest_id) references region_of_interest;
alter table region_of_interest_annotation add constraint FKACA2CAA75A2EE538 foreign key (annotation_id) references annotation;
alter table taxon_image add constraint FKF52FDBA66FA5BD2A foreign key (species_id) references taxon;
alter table taxon_image add constraint FKF52FDBA67713873C foreign key (image_id) references image;
create sequence hibernate_sequence;
