///scr_camera_step();

direction = bearing; //Change the direction to the cameras bearing

if keyboard_check(ord("W")){speed = max_speed;} //Move forward

if keyboard_check(ord("S")){speed = -max_speed;} //Move Backwards

if keyboard_check(vk_space){cam_z += 1;}

if keyboard_check(vk_shift){cam_z -= 1;}

if keyboard_check(ord("D")) //Strafe to the left
{
    x = x + lengthdir_x(max_speed/2,direction - 90);
    y = y + lengthdir_y(max_speed/2,direction - 90);
}

if keyboard_check(ord("A")) //Strafe to the right
{
    x = x + lengthdir_x(max_speed/2,direction + 90);
    y = y + lengthdir_y(max_speed/2,direction + 90);
};

friction = 0.5; //Add a little friction

bearing -= (display_mouse_get_x() -display_get_width()/2)/10;
pitch += (display_mouse_get_y() -display_get_height()/2)/10;
pitch = max(min(pitch,88),-88);
  
ss = sin(degtorad(bearing));
cc = cos(degtorad(bearing));

vector_x = cc*cos(degtorad(-pitch));
vector_y = ss*-cos(degtorad(-pitch));
vector_z = sin(degtorad(-pitch));

d3d_set_projection_ext(x, y, cam_z, x + vector_x, y + vector_y, cam_z + vector_z, 0,0,1, fov, aspect, znear, zfar);

proj_matrix = matrix_get(matrix_projection);
view_matrix = matrix_get(matrix_view);

display_mouse_set(display_get_width() / 2,display_get_height() / 2);
