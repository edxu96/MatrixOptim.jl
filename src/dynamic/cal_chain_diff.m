

function [err, vec_s, mat_x_s] = cal_chain_diff(vec_la_0, struct_data)

	z_0 = struct_data.z_0;
	y_0 = struct_data.y_0;
	s_total = struct_data.s_total;
	h = struct_data.h;

	vec_x_0 = [z_0; y_0; vec_la_0];
	[vec_s, mat_x_s] = ode45(@(s, vec_x) ode_chain(s, vec_x, struct_data), ...
		[0 s_total], vec_x_0, []);

	vec_x_end = mat_x_s(end, :)';
	vec_zy_end = vec_x_end(1:2);
	vec_la_end = vec_x_end(3:4);
	err = vec_zy_end - [h; 0];
end


function vec_x_diff = ode_chain(s, vec_x, struct_data)
	rho = struct_data.rho;
	g = struct_data.g;
	s_total = struct_data.s_total;

	z = vec_x(1);
	y = vec_x(2);
	la_z = vec_x(3);
	la_y = vec_x(4);

	theta = atan(la_y / la_z);

	z_diff = cos(theta);
	y_diff = sin(theta);
	la_z_diff = 0;
	la_y_diff = - rho * g / s_total;

	vec_x_diff = [z_diff; y_diff; la_z_diff; la_y_diff];
end
