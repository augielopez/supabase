CREATE SCHEMA resume;

CREATE TABLE resume.users (
                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                              first_name TEXT,
                              last_name TEXT,
                              username TEXT UNIQUE NOT NULL,
                              password TEXT NOT NULL,
                              email TEXT NOT NULL,
                              date_of_birth DATE,
                              address_street1 TEXT,
                              address_street2 TEXT,
                              address_city TEXT,
                              address_state TEXT,
                              address_zip TEXT,
                              is_active BOOLEAN DEFAULT TRUE,
                              created_at TIMESTAMP DEFAULT NOW(),
                              created_by TEXT,
                              updated_at TIMESTAMP DEFAULT NOW(),
                              updated_by TEXT

);

CREATE TABLE resume.personal_info (
                                      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                      user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                                      name TEXT,
                                      email TEXT UNIQUE NOT NULL,
                                      linkedin TEXT,
                                      github TEXT,
                                      created_at TIMESTAMP DEFAULT NOW(),
                                      created_by TEXT,
                                      updated_at TIMESTAMP DEFAULT NOW(),
                                      updated_by TEXT
);

CREATE TABLE resume.education (
                                  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                  user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                                  school TEXT NOT NULL,
                                  degree TEXT NOT NULL,
                                  start_year INT,
                                  end_year INT,
                                  gpa NUMERIC(3,2),
                                  details TEXT,
                                  created_at TIMESTAMP DEFAULT NOW(),
                                  created_by TEXT,
                                  updated_at TIMESTAMP DEFAULT NOW(),
                                  updated_by TEXT
);

CREATE TABLE resume.skills (
                               id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                               user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                               skill_name TEXT NOT NULL,
                               proficiency_level TEXT,
                               created_at TIMESTAMP DEFAULT NOW(),
                               created_by TEXT,
                               updated_at TIMESTAMP DEFAULT NOW(),
                               updated_by TEXT
);

CREATE TABLE resume.experience (
                                   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                   user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                                   job_title TEXT NOT NULL,
                                   company TEXT NOT NULL,
                                   start_date DATE,
                                   end_date DATE,
                                   description TEXT,
                                   created_at TIMESTAMP DEFAULT NOW(),
                                   created_by TEXT,
                                   updated_at TIMESTAMP DEFAULT NOW(),
                                   updated_by TEXT
);

CREATE TABLE resume.experience_bullets (
                                           id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                           experience_id UUID REFERENCES resume.experience(id) ON DELETE CASCADE,
                                           bullet_point TEXT NOT NULL,  -- Each job responsibility or achievement
                                           created_at TIMESTAMP DEFAULT NOW(),
                                           created_by TEXT,
                                           updated_at TIMESTAMP DEFAULT NOW(),
                                           updated_by TEXT
);

CREATE TABLE resume.experience_bullets_tags (
                                                experience_bullet_id UUID REFERENCES resume.experience_bullets(id) ON DELETE CASCADE,
                                                tag_id UUID REFERENCES resume.tags(id) ON DELETE CASCADE,
                                                PRIMARY KEY (experience_bullet_id, tag_id)
);


CREATE TABLE resume.projects (
                                 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                 user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                                 project_name TEXT NOT NULL,
                                 description TEXT,
                                 technologies TEXT,
                                 url TEXT,
                                 created_at TIMESTAMP DEFAULT NOW(),
                                 created_by TEXT,
                                 updated_at TIMESTAMP DEFAULT NOW(),
                                 updated_by TEXT
);

CREATE TABLE resume.tags (
                             id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                             user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                             tag_name TEXT NOT NULL UNIQUE,
                             created_at TIMESTAMP DEFAULT NOW(),
                             created_by TEXT,
                             updated_at TIMESTAMP DEFAULT NOW(),
                             updated_by TEXT
);

CREATE TABLE resume.experience_tags (
                                        experience_id UUID REFERENCES resume.experience(id) ON DELETE CASCADE,
                                        tag_id UUID REFERENCES resume.tags(id) ON DELETE CASCADE,
                                        PRIMARY KEY (experience_id, tag_id)
);

CREATE TABLE resume.skills_tags (
                                    skill_id UUID REFERENCES resume.skills(id) ON DELETE CASCADE,
                                    tag_id UUID REFERENCES resume.tags(id) ON DELETE CASCADE,
                                    PRIMARY KEY (skill_id, tag_id)
);

CREATE TABLE resume.projects_tags (
                                      project_id UUID REFERENCES resume.projects(id) ON DELETE CASCADE,
                                      tag_id UUID REFERENCES resume.tags(id) ON DELETE CASCADE,
                                      PRIMARY KEY (project_id, tag_id)
);

CREATE TABLE resume.certifications (
                                       id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                       user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                                       certification_name TEXT NOT NULL,
                                       issuing_organization TEXT,
                                       issue_date DATE,
                                       expiration_date DATE,
                                       details TEXT,
                                       created_at TIMESTAMP DEFAULT NOW(),
                                       created_by TEXT,
                                       updated_at TIMESTAMP DEFAULT NOW(),
                                       updated_by TEXT
);

CREATE TABLE resume.languages (
                                  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                  user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                                  language_name TEXT NOT NULL,
                                  proficiency_level TEXT,
                                  created_at TIMESTAMP DEFAULT NOW(),
                                  created_by TEXT,
                                  updated_at TIMESTAMP DEFAULT NOW(),
                                  updated_by TEXT
);

CREATE TABLE resume.references (
                                   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                   user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                                   reference_name TEXT NOT NULL,
                                   relationship TEXT,
                                   contact_info TEXT,
                                   created_at TIMESTAMP DEFAULT NOW(),
                                   created_by TEXT,
                                   updated_at TIMESTAMP DEFAULT NOW(),
                                   updated_by TEXT
);

CREATE TABLE resume.notes (
                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                              user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                              note TEXT NOT NULL,
                              created_at TIMESTAMP DEFAULT NOW(),
                              created_by TEXT,
                              updated_at TIMESTAMP DEFAULT NOW(),
                              updated_by TEXT
);

CREATE TABLE resume.summary (
                                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                                summary_text TEXT NOT NULL,
                                created_at TIMESTAMP DEFAULT NOW(),
                                created_by TEXT,
                                updated_at TIMESTAMP DEFAULT NOW(),
                                updated_by TEXT
);

CREATE TABLE resume.main (
                             id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                             user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                             title TEXT NOT NULL DEFAULT 'Main',
                             created_at TIMESTAMP DEFAULT NOW(),
                             created_by TEXT,
                             updated_at TIMESTAMP DEFAULT NOW(),
                             updated_by TEXT
);

CREATE TABLE resume.saved (
                              id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                              user_id UUID REFERENCES resume.users(id) ON DELETE CASCADE,
                              resume_name TEXT NOT NULL,  -- Example: "Frontend Resume"
                              main_resume_id UUID REFERENCES resume.main(id) ON DELETE CASCADE,
                              created_at TIMESTAMP DEFAULT NOW(),
                              created_by TEXT,
                              updated_at TIMESTAMP DEFAULT NOW(),
                              updated_by TEXT
);

CREATE TABLE resume.sections (
                                 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                 saved_id UUID REFERENCES resume.saved(id) ON DELETE CASCADE,

                                 skill_id UUID REFERENCES resume.skills(id) ON DELETE CASCADE,
                                 project_id UUID REFERENCES resume.projects(id) ON DELETE CASCADE,
                                 education_id UUID REFERENCES resume.education(id) ON DELETE CASCADE,
                                 experience_id UUID REFERENCES resume.experience(id) ON DELETE CASCADE,
                                 certification_id UUID REFERENCES resume.certifications(id) ON DELETE CASCADE,
                                 language_id UUID REFERENCES resume.languages(id) ON DELETE CASCADE,
                                 reference_id UUID REFERENCES resume.references(id) ON DELETE CASCADE,
                                 summary_id UUID REFERENCES resume.summary(id) ON DELETE CASCADE,
                                 note_id UUID REFERENCES resume.notes(id) ON DELETE CASCADE,

                                 created_at TIMESTAMP DEFAULT NOW(),
                                 created_by TEXT,
                                 updated_at TIMESTAMP DEFAULT NOW(),
                                 updated_by TEXT,

                                 CONSTRAINT check_section_integrity CHECK (
                                         (skill_id IS NOT NULL AND project_id IS NULL AND education_id IS NULL AND experience_id IS NULL AND certification_id IS NULL AND language_id IS NULL AND reference_id IS NULL AND summary_id IS NULL AND note_id IS NULL) OR
                                         (project_id IS NOT NULL AND skill_id IS NULL AND education_id IS NULL AND experience_id IS NULL AND certification_id IS NULL AND language_id IS NULL AND reference_id IS NULL AND summary_id IS NULL AND note_id IS NULL) OR
                                         (education_id IS NOT NULL AND skill_id IS NULL AND project_id IS NULL AND experience_id IS NULL AND certification_id IS NULL AND language_id IS NULL AND reference_id IS NULL AND summary_id IS NULL AND note_id IS NULL) OR
                                         (experience_id IS NOT NULL AND skill_id IS NULL AND project_id IS NULL AND education_id IS NULL AND certification_id IS NULL AND language_id IS NULL AND reference_id IS NULL AND summary_id IS NULL AND note_id IS NULL) OR
                                         (certification_id IS NOT NULL AND skill_id IS NULL AND project_id IS NULL AND education_id IS NULL AND experience_id IS NULL AND language_id IS NULL AND reference_id IS NULL AND summary_id IS NULL AND note_id IS NULL) OR
                                         (language_id IS NOT NULL AND skill_id IS NULL AND project_id IS NULL AND education_id IS NULL AND experience_id IS NULL AND certification_id IS NULL AND reference_id IS NULL AND summary_id IS NULL AND note_id IS NULL) OR
                                         (reference_id IS NOT NULL AND skill_id IS NULL AND project_id IS NULL AND education_id IS NULL AND experience_id IS NULL AND certification_id IS NULL AND language_id IS NULL AND summary_id IS NULL AND note_id IS NULL) OR
                                         (summary_id IS NOT NULL AND skill_id IS NULL AND project_id IS NULL AND education_id IS NULL AND experience_id IS NULL AND certification_id IS NULL AND language_id IS NULL AND reference_id IS NULL AND note_id IS NULL) OR
                                         (note_id IS NOT NULL AND skill_id IS NULL AND project_id IS NULL AND education_id IS NULL AND experience_id IS NULL AND certification_id IS NULL AND language_id IS NULL AND reference_id IS NULL AND summary_id IS NULL)
                                     )
);

CREATE TABLE resume.project_technologies (
                                             id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                             project_id UUID REFERENCES resume.projects(id) ON DELETE CASCADE,
                                             technology_name TEXT NOT NULL,
                                             created_at TIMESTAMP DEFAULT NOW(),
                                             created_by TEXT,
                                             updated_at TIMESTAMP DEFAULT NOW(),
                                             updated_by TEXT
);


ALTER TABLE resume.main
    ADD CONSTRAINT unique_main_resume_per_user UNIQUE (user_id);

ALTER TABLE resume.saved
    ADD CONSTRAINT unique_saved_resume_name_per_user UNIQUE (user_id, resume_name);



-- Grant privileges to Supabase's `authenticated` and `anon` roles
grant usage on schema resume to authenticated, anon;
grant select, insert, update, delete on all tables in schema resume to authenticated, anon;

-- Ensure future tables are accessible too
alter default privileges in schema resume
    grant select, insert, update, delete on tables to authenticated, anon;

create or replace view public.resume_users as
select * from resume.users;

create or replace view public.resume_summary as
select * from resume.summary;

grant select, insert, update, delete on public.resume_summary to anon, authenticated;




-- 1. Drop the public-facing view (if it exists)
drop view if exists public.resume_users;

-- 2. Drop the main table and all constraints/views that depend on it
drop table resume.users cascade;

-- 3. Recreate the table with your updated definition

-- 4. Recreate the view
create or replace view public.resume_users as
select * from resume.users;

-- 5. Re-add permissions
grant select, insert, update, delete on public.resume_users to anon, authenticated;


