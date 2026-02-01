var fix =  physics_fixture_create();
physics_fixture_set_box_shape(fix, half_width, half_height);
physics_fixture_set_collision_group(fix, 1);
physics_fixture_set_sensor(fix, true);
physics_fixture_bind(fix, id);
physics_fixture_delete(fix);