#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul  2 13:14:32 2019
This is for pysplit(Python-Hysplit), have made the trajectories
@author: qingn
"""
from __future__ import print_function
import sys; sys.executable
import xarray as xry
#import dask
#import mpl_toolkits
#import mpl_toolkits.basemap as bm
#from mpl_toolkits.basemap import Basemap, cm
#from numpy import interp
#import matplotlib as mpl
#import astral
#import act
import pandas as pd
import numpy as np
import netCDF4
import datetime
import os

import matplotlib.pyplot as plt
#import weather_modules as wm
#import sounding_modules as sm

import pysplit

# %% 
'''
bulk_trajgen_example
'''

working_dir = r'/Users/qingn/Hysplit4/working'
storage_dir = r'/Users/qingn/Desktop/NQ/radiosondes_micre/trajectories'
meteo_dir = r'/Users/qingn/Desktop/NQ/radiosondes_micre/gdas'

basename = 'trajectories'

years = [2016,2017]
months = [4,4]
hours = [11,17,23]
altitudes = [1000, 3000, 5000]
location = (-54.62,158.85)
runtime = -72
pysplit.generate_bulktraj(basename, working_dir, storage_dir, meteo_dir,
                          years, months, hours, altitudes, location, runtime,
                          monthslice=slice(0, 32, 2), get_reverse=True,
                          get_clipped=True)
# %%
'''
basic plotting example
'''

trajgroup = pysplit.make_trajectorygroup('/Users/qingn/Desktop/NQ/radiosondes_micre/trajectories/trajector*')

"""
Basemaps and MapDesign
----------------------
PySPLIT's ``MapDesign`` class uses the matplotlib Basemap toolkit to quickly
set up attractive maps.  The user is not restricted to using maps
produced from ``MapDesign``, however- any Basemap will serve in the section
below entitled 'Plotting ``Trajectory`` Paths.
Creating a basic cylindrical map using ``MapDesign``  only requires
``mapcorners``, a list of the lower-left longitude, lower-left latitude,
upper-right longitude, and upper-right latitude values.
The ``standard_pm``, a list of standard parallels and meridians,
may be passed as ``None``.
"""
mapcorners =  [30, -80, 180, -30]
standard_pm = None

bmap_params = pysplit.MapDesign(mapcorners, standard_pm)

"""
Once the ``MapDesign`` is initialized it can be used to draw a map:
"""
bmap = bmap_params.make_basemap()

"""
Plotting ``Trajectory`` Paths
-----------------------------
For this example, we will color-code by initialization (t=0) altitude,
(500, 1000, or 1500 m), which can be accessed via ``Trajectory.data.geometry``,
 a ``GeoSeries`` of Shapely ``Point`` objects.
We can store the trajectory color in ``Trajectory.trajcolor`` for convenience.
"""
color_dict = {1000.0 : 'blue',
              3000.0 : 'orange',
              5000.0 : 'yellow'}

for traj in trajgroup:
    altitude0 = traj.data.geometry.apply(lambda p: p.z)[0]
    traj.trajcolor = color_dict[altitude0]

"""
For display purposes, let's plot only every fifth ``Trajectory``.  The lats,
lons are obtained by unpacking the ``Trajectory.Path``
(Shapely ``LineString``) xy coordinates.
"""
for traj in trajgroup[::5]:
    bmap.plot(*traj.path.xy, c=traj.trajcolor, latlon=True, zorder=20)

# %%
'''
traj_trajgroup_basics_example

'''


"""
===========================================================
Getting Started with ``TrajectoryGroup`` and ``Trajectory``
===========================================================
The basic PySPLIT workflow consists of cycling through ``TrajectoryGroup``
containers of ``Trajectory`` objects and acting on each ``Trajectory``,
refining the ``TrajectoryGroup`` or creating new ones as necessary.
Initializing the first ``TrajectoryGroup``
------------------------------------------
The first ``TrajectoryGroup`` requires ``Trajectory`` objects to be
initialized from trajectory files.  Here we initialize all of the trajectories
created in ``bulk_trajgen_example.py``.
"""



trajgroup = pysplit.make_trajectorygroup(r'/Users/qingn/Desktop/NQ/radiosondes_micre/trajectories/trajector*')

"""
Workflow
--------
Cycle through the ``TrajectoryGroup`` and act on each trajectory.  Below 
are some sample geometry calculations.
"""
for traj in trajgroup:
    traj.calculate_distance()
    traj.calculate_vector()

"""
Let's create a new ``TrajectoryGroup`` with a list of some of the
``Trajectory`` objects in ``tg``.  For this example, we'll make
a group consisting only of trajectories with rainfall at timepoint 0.
Note- this will only work as written if rainfall was selected as
an output meteorological variable during trajectory generation.  Alternatively,
``Trajectory.set_rainstatus()`` can use humidity variables if those
are available and if the appropriate kwargs are provided.
"""
rainylist = []

for traj in trajgroup:
    traj.set_rainstatus()
    if traj.rainy:
        rainylist.append(traj)
        
rainy_trajgroup = pysplit.TrajectoryGroup(rainylist)

"""
A new ``TrajectoryGroup`` can also be created by addition or subtraction.
Let's subtract our new ``rainy_trajgroup`` from the original
``TrajectoryGroup``, ``trajgroup``.  This yields a new ``TrajectoryGroup``
with only non-rainfall producing trajectories.  The number of 
member ``Trajectory`` objects can be checked using
``TrajectoryGroup.trajcount``
"""
dry_trajgroup = trajgroup - rainy_trajgroup

print(dry_trajgroup.trajcount)
print(rainy_trajgroup.trajcount)
print(trajgroup.trajcount)