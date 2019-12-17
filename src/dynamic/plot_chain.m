

function plot_chain(x1, y1, x2, y2)
	figure

	plot(x1, y1, 'b', x2, y2, 'r-.', 'LineWidth', 2)
	% Turn on the grid
	grid on
	% Set the axis limits
	% axis([0 2*pi -1.5 1.5])
	% Add title and axis labels
	title('Trajectories of Suspended Chains')
	xlabel('z')
	ylabel('y')
	legend('when N = 6','when N = 100')
end
