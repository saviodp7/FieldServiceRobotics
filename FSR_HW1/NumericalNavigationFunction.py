import numpy as np
import timeit

grid_map = np.matrix("1 0 0 1 1 1 1 1 1 1;"
                     "1 1 0 1 1 1 1 0 0 1;"
                     "1 1 0 1 0 1 1 0 1 1;"
                     "1 1 0 1 0 1 1 0 1 1;"
                     "1 1 0 1 0 0 1 0 1 1;"
                     "1 1 1 1 1 1 1 1 1 1;"
                     "1 1 1 1 1 1 0 1 1 1")

q_start = [0, 7]
q_goal = [0, 0]


def get_adj_orth_cells(cell_list, nav_map):
    """
    :param cell_list: list of cells
    :param nav_map: map of costs, we need only the dimension
    :return: feasible adjacent orthogonal cells of every cell in the cell_list
    """
    adjacent_cells = list()
    for cell in cell_list:
        if cell[0]-1 >= 0:
            adjacent_cells.append([cell[0]-1, cell[1]])
        if cell[0]+1 < np.shape(nav_map)[0]:
            adjacent_cells.append([cell[0]+1, cell[1]])
        if cell[1]-1 >= 0:
            adjacent_cells.append([cell[0], cell[1]-1])
        if cell[1]+1 < np.shape(nav_map)[1]:
            adjacent_cells.append([cell[0], cell[1]+1])
    return adjacent_cells


def get_adj_cells(cell_list, nav_map):
    """
    :param cell_list: list of cells
    :param nav_map: map of costs, we need only the dimension
    :return: feasible adjacent cells of every cell in the cell_list
    """
    adjacent_cells = list()
    for cell in cell_list:
        if cell[0]-1 >= 0 and cell[1]-1 >= 0:
            adjacent_cells.append([cell[0]-1, cell[1]-1])
        if cell[0]-1 >= 0:
            adjacent_cells.append([cell[0]-1, cell[1]])
        if cell[0]-1 >= 0 and cell[1]+1 < np.shape(nav_map)[1]:
            adjacent_cells.append([cell[0]-1, cell[1]+1])
        if cell[1]+1 < np.shape(nav_map)[1]:
            adjacent_cells.append([cell[0], cell[1]+1])
        if cell[1]+1 < np.shape(nav_map)[1] and cell[0]+1 < np.shape(nav_map)[0]:
            adjacent_cells.append([cell[0]+1, cell[1]+1])
        if cell[0]+1 < np.shape(nav_map)[0]:
            adjacent_cells.append([cell[0]+1, cell[1]])
        if cell[0]+1 < np.shape(nav_map)[0] and cell[1]-1 >= 0:
            adjacent_cells.append([cell[0]+1, cell[1]-1])
        if cell[1]-1 >= 0:
            adjacent_cells.append([cell[0], cell[1]-1])

    return adjacent_cells


def compute_cost_map(cells, nav_map, exploration_func):
    compute_cost_map.counter += 1
    """
    Update the cells of the nav_map with the value
    :param cells: cells to check in the nav map
    :param nav_map: cost map
    """
    to_explore = list()
    if 0 in nav_map:
        while cells:
            cell = cells.pop()
            if grid_map[cell[0], cell[1]] == 1 and nav_map[cell[0], cell[1]] == 0:
                nav_map[cell[0], cell[1]] = compute_cost_map.counter
                to_explore.append(cell)
            elif grid_map[cell[0], cell[1]] == 0:
                nav_map[cell[0], cell[1]] = -1
        adjacent_cells = exploration_func(to_explore, nav_map)
        compute_cost_map(adjacent_cells, nav_map, exploration_func)


def steepest_descent(start_cell, nav_map, exploration_func):
    steepest_descent.counter += 1
    feasible_cells = dict()
    if not nav_map[start_cell[0], start_cell[1]] == 0:
        adjacent_cells = exploration_func([start_cell], nav_map)
        for cell in adjacent_cells:
            if nav_map[cell[0], cell[1]] >= 0:
                feasible_cells[nav_map[cell[0], cell[1]]] = cell
        best_cell = feasible_cells[min(feasible_cells.keys())]
        print(f'->{best_cell}', end="")
        steepest_descent(best_cell, nav_map, exploration_func)


def main(exploration_func):
    start = timeit.default_timer()
    num_nav_map = np.zeros(np.shape(grid_map))
    adjacent_cells = exploration_func([q_goal], num_nav_map)
    compute_cost_map.counter = 0
    compute_cost_map(adjacent_cells, num_nav_map, exploration_func)
    num_nav_map[q_goal[0]][q_goal[1]] = 0
    print(f'Computed cost map:\n{num_nav_map}\nExecution time: {timeit.default_timer() - start:.6f}s')

    start = timeit.default_timer()
    print(f'Best path:{q_start}', end="")
    steepest_descent.counter = 0
    steepest_descent(q_start, num_nav_map, exploration_func)
    print(f'\nPath length: {steepest_descent.counter}')
    print(f'Execution time: {timeit.default_timer() - start:.6f}s\n')


if __name__ == "__main__":

    # 4-ADJACENT EXPLORATION #
    main(get_adj_orth_cells)
    # 8-ADJACENT EXPLORATION #
    main(get_adj_cells)
