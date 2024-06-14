#!/usr/bin/env python3
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# amdgpu_metrics.py decode amdgpu metrics from sysfs
# Copyright (C) 2021 leuc
#
# This program is free software: you can redistribute it and/or modify it under the
# terms of the GNU Affero General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <https://www.gnu.org/licenses/>.

import argparse
import ctypes
from json import dumps
from enum import IntFlag

COMMON_HEADER_SIZE = 4


class ThrottleStatus(IntFlag):
    # linux/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
    PPT0 = 1 << 0
    PPT1 = 1 << 1
    PPT2 = 1 << 2
    PPT3 = 1 << 3
    SPL = 1 << 4
    FPPT = 1 << 5
    SPPT = 1 << 6
    SPPT_APU = 1 << 7
    TDC_GFX = 1 << 16
    TDC_SOC = 1 << 17
    TDC_MEM = 1 << 18
    TDC_VDD = 1 << 19
    TDC_CVIP = 1 << 20
    EDC_CPU = 1 << 21
    EDC_GFX = 1 << 22
    APCC = 1 << 23
    TEMP_GPU = 1 << 32
    TEMP_CORE = 1 << 33
    TEMP_MEM = 1 << 34
    TEMP_EDGE = 1 << 35
    TEMP_HOTSPOT = 1 << 36
    TEMP_SOC = 1 << 37
    TEMP_VR_GFX = 1 << 38
    TEMP_VR_SOC = 1 << 39
    TEMP_VR_MEM0 = 1 << 40
    TEMP_VR_MEM1 = 1 << 41
    TEMP_LIQUID0 = 1 << 42
    TEMP_LIQUID1 = 1 << 43
    VRHOT0 = 1 << 44
    VRHOT1 = 1 << 45
    PROCHOT_CPU = 1 << 46
    PROCHOT_GFX = 1 << 47
    PPM = 1 << 56
    FIT = 1 << 57

    def active(self):
        members = self.__class__.__members__
        return (m for m in members if getattr(self, m)._value_ & self.value != 0)

    def __iter__(self):
        return self.active()

    def __str__(self):
        return u', '.join(self.active())


class GpuMetrics(ctypes.Structure):
    def __new__(cls, buf):
        return cls.from_buffer_copy(buf)

    def __init__(self, data):
        pass

    def __iter__(self):
        return ((f[0], getattr(self, f[0])) for f in self._fields_)

    def __str__(self):
        a = [u'{}: {}'.format(f[0], getattr(self, f[0]))
             for f in self._fields_]
        return u'> {}\n'.format(type(self).__name__) + u'\n'.join(a)


class MetricsTableHeader(GpuMetrics):
    _fields_ = [
        ('structure_size', ctypes.c_uint16),
        ('format_revision', ctypes.c_uint8),
        ('content_revision', ctypes.c_uint8),
    ]

# AMD GPU metrics defined in
# linux/drivers/gpu/drm/amd/include/kgd_pp_interface.h


class GpuMetrics_v1_0(GpuMetrics):
    _fields_ = [
        ('system_clock_counter', ctypes.c_uint64),
        ('temperature_edge', ctypes.c_uint16),
        ('temperature_hotspot', ctypes.c_uint16),
        ('temperature_mem', ctypes.c_uint16),
        ('temperature_vrgfx', ctypes.c_uint16),
        ('temperature_vrsoc', ctypes.c_uint16),
        ('temperature_vrmem', ctypes.c_uint16),
        ('average_gfx_activity', ctypes.c_uint16),
        ('average_umc_activity', ctypes.c_uint16),
        ('average_mm_activity', ctypes.c_uint16),
        ('average_socket_power', ctypes.c_uint16),
        ('energy_accumulator', ctypes.c_uint32),
        ('average_gfxclk_frequency', ctypes.c_uint16),
        ('average_socclk_frequency', ctypes.c_uint16),
        ('average_uclk_frequency', ctypes.c_uint16),
        ('average_vclk0_frequency', ctypes.c_uint16),
        ('average_dclk0_frequency', ctypes.c_uint16),
        ('average_vclk1_frequency', ctypes.c_uint16),
        ('average_dclk1_frequency', ctypes.c_uint16),
        ('current_gfxclk', ctypes.c_uint16),
        ('current_socclk', ctypes.c_uint16),
        ('current_uclk', ctypes.c_uint16),
        ('current_vclk0', ctypes.c_uint16),
        ('current_dclk0', ctypes.c_uint16),
        ('current_vclk1', ctypes.c_uint16),
        ('current_dclk1', ctypes.c_uint16),
        ('throttle_status', ctypes.c_uint32),
        ('current_fan_speed', ctypes.c_uint16),
        ('pcie_link_width', ctypes.c_uint8),
        ('pcie_link_speed', ctypes.c_uint8),
    ]


class GpuMetrics_v1_1(GpuMetrics):
    _fields_ = [
        ('temperature_edge', ctypes.c_uint16),
        ('temperature_hotspot', ctypes.c_uint16),
        ('temperature_mem', ctypes.c_uint16),
        ('temperature_vrgfx', ctypes.c_uint16),
        ('temperature_vrsoc', ctypes.c_uint16),
        ('temperature_vrmem', ctypes.c_uint16),
        ('average_gfx_activity', ctypes.c_uint16),
        ('average_umc_activity', ctypes.c_uint16),
        ('average_mm_activity', ctypes.c_uint16),
        ('average_socket_power', ctypes.c_uint16),
        ('energy_accumulator', ctypes.c_uint64),
        ('system_clock_counter', ctypes.c_uint64),
        ('average_gfxclk_frequency', ctypes.c_uint16),
        ('average_socclk_frequency', ctypes.c_uint16),
        ('average_uclk_frequency', ctypes.c_uint16),
        ('average_vclk0_frequency', ctypes.c_uint16),
        ('average_dclk0_frequency', ctypes.c_uint16),
        ('average_vclk1_frequency', ctypes.c_uint16),
        ('average_dclk1_frequency', ctypes.c_uint16),
        ('current_gfxclk', ctypes.c_uint16),
        ('current_socclk', ctypes.c_uint16),
        ('current_uclk', ctypes.c_uint16),
        ('current_vclk0', ctypes.c_uint16),
        ('current_dclk0', ctypes.c_uint16),
        ('current_vclk1', ctypes.c_uint16),
        ('current_dclk1', ctypes.c_uint16),
        ('throttle_status', ctypes.c_uint32),
        ('current_fan_speed', ctypes.c_uint16),
        ('pcie_link_width', ctypes.c_uint16),
        ('pcie_link_speed', ctypes.c_uint16),
        ('padding', ctypes.c_uint16),
        ('gfx_activity_acc', ctypes.c_uint32),
        ('mem_activity_acc', ctypes.c_uint32),
        ('temperature_hbm', ctypes.c_uint16),
    ]


class GpuMetrics_v1_2(GpuMetrics):
    _fields_ = [
        ('temperature_edge', ctypes.c_uint16),
        ('temperature_hotspot', ctypes.c_uint16),
        ('temperature_mem', ctypes.c_uint16),
        ('temperature_vrgfx', ctypes.c_uint16),
        ('temperature_vrsoc', ctypes.c_uint16),
        ('temperature_vrmem', ctypes.c_uint16),
        ('average_gfx_activity', ctypes.c_uint16),
        ('average_umc_activity', ctypes.c_uint16),
        ('average_mm_activity', ctypes.c_uint16),
        ('average_socket_power', ctypes.c_uint16),
        ('energy_accumulator', ctypes.c_uint64),
        ('system_clock_counter', ctypes.c_uint64),
        ('average_gfxclk_frequency', ctypes.c_uint16),
        ('average_socclk_frequency', ctypes.c_uint16),
        ('average_uclk_frequency', ctypes.c_uint16),
        ('average_vclk0_frequency', ctypes.c_uint16),
        ('average_dclk0_frequency', ctypes.c_uint16),
        ('average_vclk1_frequency', ctypes.c_uint16),
        ('average_dclk1_frequency', ctypes.c_uint16),
        ('current_gfxclk', ctypes.c_uint16),
        ('current_socclk', ctypes.c_uint16),
        ('current_uclk', ctypes.c_uint16),
        ('current_vclk0', ctypes.c_uint16),
        ('current_dclk0', ctypes.c_uint16),
        ('current_vclk1', ctypes.c_uint16),
        ('current_dclk1', ctypes.c_uint16),
        ('throttle_status', ctypes.c_uint32),
        ('current_fan_speed', ctypes.c_uint16),
        ('pcie_link_width', ctypes.c_uint16),
        ('pcie_link_speed', ctypes.c_uint16),
        ('padding', ctypes.c_uint16),
        ('gfx_activity_acc', ctypes.c_uint32),
        ('mem_activity_acc', ctypes.c_uint32),
        ('temperature_hbm', ctypes.c_uint16),
        ('firmware_timestamp', ctypes.c_uint64),
    ]


class GpuMetrics_v1_3(GpuMetrics):
    _fields_ = [
        ('temperature_edge', ctypes.c_uint16),
        ('temperature_hotspot', ctypes.c_uint16),
        ('temperature_mem', ctypes.c_uint16),
        ('temperature_vrgfx', ctypes.c_uint16),
        ('temperature_vrsoc', ctypes.c_uint16),
        ('temperature_vrmem', ctypes.c_uint16),
        ('average_gfx_activity', ctypes.c_uint16),
        ('average_umc_activity', ctypes.c_uint16),
        ('average_mm_activity', ctypes.c_uint16),
        ('average_socket_power', ctypes.c_uint16),
        ('energy_accumulator', ctypes.c_uint64),
        ('system_clock_counter', ctypes.c_uint64),
        ('average_gfxclk_frequency', ctypes.c_uint16),
        ('average_socclk_frequency', ctypes.c_uint16),
        ('average_uclk_frequency', ctypes.c_uint16),
        ('average_vclk0_frequency', ctypes.c_uint16),
        ('average_dclk0_frequency', ctypes.c_uint16),
        ('average_vclk1_frequency', ctypes.c_uint16),
        ('average_dclk1_frequency', ctypes.c_uint16),
        ('current_gfxclk', ctypes.c_uint16),
        ('current_socclk', ctypes.c_uint16),
        ('current_uclk', ctypes.c_uint16),
        ('current_vclk0', ctypes.c_uint16),
        ('current_dclk0', ctypes.c_uint16),
        ('current_vclk1', ctypes.c_uint16),
        ('current_dclk1', ctypes.c_uint16),
        ('throttle_status', ctypes.c_uint32),
        ('current_fan_speed', ctypes.c_uint16),
        ('pcie_link_width', ctypes.c_uint16),
        ('pcie_link_speed', ctypes.c_uint16),
        ('padding', ctypes.c_uint16),
        ('gfx_activity_acc', ctypes.c_uint32),
        ('mem_activity_acc', ctypes.c_uint32),
        ('temperature_hbm', ctypes.c_uint16),
        ('firmware_timestamp', ctypes.c_uint64),
        ('voltage_soc', ctypes.c_uint16),
        ('voltage_gfx', ctypes.c_uint16),
        ('voltage_mem', ctypes.c_uint16),
        ('padding1', ctypes.c_uint8),
        # FIXME Doesn't match output on 5.15.0-051500rc7-generic
        # with Navi 10 RX 5600
        # ('indep_throttle_status', ctypes.c_uint64),
    ]


class GpuMetrics_v2_0(GpuMetrics):
    _fields_ = [
        ('system_clock_counter', ctypes.c_uint64),
        ('temperature_gfx', ctypes.c_uint16),
        ('temperature_soc', ctypes.c_uint16),
        ('temperature_core', ctypes.c_uint16),
        ('temperature_l3', ctypes.c_uint16),
        ('average_gfx_activity', ctypes.c_uint16),
        ('average_mm_activity', ctypes.c_uint16),
        ('average_socket_power', ctypes.c_uint16),
        ('average_cpu_power', ctypes.c_uint16),
        ('average_soc_power', ctypes.c_uint16),
        ('average_gfx_power', ctypes.c_uint16),
        ('average_core_power', ctypes.c_uint16),
        ('average_gfxclk_frequency', ctypes.c_uint16),
        ('average_socclk_frequency', ctypes.c_uint16),
        ('average_uclk_frequency', ctypes.c_uint16),
        ('average_fclk_frequency', ctypes.c_uint16),
        ('average_vclk_frequency', ctypes.c_uint16),
        ('average_dclk_frequency', ctypes.c_uint16),
        ('current_gfxclk', ctypes.c_uint16),
        ('current_socclk', ctypes.c_uint16),
        ('current_uclk', ctypes.c_uint16),
        ('current_fclk', ctypes.c_uint16),
        ('current_vclk', ctypes.c_uint16),
        ('current_dclk', ctypes.c_uint16),
        ('current_coreclk', ctypes.c_uint16),
        ('current_l3clk', ctypes.c_uint16),
        ('throttle_status', ctypes.c_uint32),
        ('fan_pwm', ctypes.c_uint16),
        ('padding', ctypes.c_uint16),
    ]


class GpuMetrics_v2_1(GpuMetrics):
    _fields_ = [
        ('temperature_gfx', ctypes.c_uint16),
        ('temperature_soc', ctypes.c_uint16),
        ('temperature_core', ctypes.c_uint16),
        ('temperature_l3', ctypes.c_uint16),
        ('average_gfx_activity', ctypes.c_uint16),
        ('average_mm_activity', ctypes.c_uint16),
        ('system_clock_counter', ctypes.c_uint64),
        ('average_socket_power', ctypes.c_uint16),
        ('average_cpu_power', ctypes.c_uint16),
        ('average_soc_power', ctypes.c_uint16),
        ('average_gfx_power', ctypes.c_uint16),
        ('average_core_power', ctypes.c_uint16),
        ('average_gfxclk_frequency', ctypes.c_uint16),
        ('average_socclk_frequency', ctypes.c_uint16),
        ('average_uclk_frequency', ctypes.c_uint16),
        ('average_fclk_frequency', ctypes.c_uint16),
        ('average_vclk_frequency', ctypes.c_uint16),
        ('average_dclk_frequency', ctypes.c_uint16),
        ('current_gfxclk', ctypes.c_uint16),
        ('current_socclk', ctypes.c_uint16),
        ('current_uclk', ctypes.c_uint16),
        ('current_fclk', ctypes.c_uint16),
        ('current_vclk', ctypes.c_uint16),
        ('current_dclk', ctypes.c_uint16),
        ('current_coreclk', ctypes.c_uint16),
        ('current_l3clk', ctypes.c_uint16),
        ('throttle_status', ctypes.c_uint32),
        ('fan_pwm', ctypes.c_uint16),
        ('padding', ctypes.c_uint16),
    ]


class GpuMetrics_v2_2(GpuMetrics):
    _fields_ = [
        ('temperature_gfx', ctypes.c_uint16),
        ('temperature_soc', ctypes.c_uint16),
        ('temperature_core', ctypes.c_uint16),
        ('temperature_l3', ctypes.c_uint16),
        ('average_gfx_activity', ctypes.c_uint16),
        ('average_mm_activity', ctypes.c_uint16),
        ('system_clock_counter', ctypes.c_uint64),
        ('average_socket_power', ctypes.c_uint16),
        ('average_socket_power', ctypes.c_uint16),
        ('average_cpu_power', ctypes.c_uint16),
        ('average_soc_power', ctypes.c_uint16),
        ('average_gfx_power', ctypes.c_uint16),
        ('average_core_power', ctypes.c_uint16),
        ('average_gfxclk_frequency', ctypes.c_uint16),
        ('average_socclk_frequency', ctypes.c_uint16),
        ('average_uclk_frequency', ctypes.c_uint16),
        ('average_fclk_frequency', ctypes.c_uint16),
        ('average_vclk_frequency', ctypes.c_uint16),
        ('average_dclk_frequency', ctypes.c_uint16),
        ('current_gfxclk', ctypes.c_uint16),
        ('current_socclk', ctypes.c_uint16),
        ('current_uclk', ctypes.c_uint16),
        ('current_fclk', ctypes.c_uint16),
        ('current_vclk', ctypes.c_uint16),
        ('current_dclk', ctypes.c_uint16),
        ('current_coreclk', ctypes.c_uint16),
        ('current_l3clk', ctypes.c_uint16),
        ('throttle_status', ctypes.c_uint32),
        ('fan_pwm', ctypes.c_uint16),
        ('padding', ctypes.c_uint16),
        ('indep_throttle_status', ctypes.c_uint64),
    ]


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('files', nargs='+',
                        help='Path to gpu_metrics file under /sys')
    parser.add_argument('-j', '--json',
                        help='Format output as JSON', action="store_true")
    args = parser.parse_args()

    for filename in args.files:
        with open(filename, mode='rb') as fh:
            header = MetricsTableHeader(fh.read(COMMON_HEADER_SIZE))
            assert header.structure_size > 0

            buf = fh.read(header.structure_size)
            assert len(buf) + COMMON_HEADER_SIZE == header.structure_size
            assert fh.read() == b''  # should be empty

            if header.format_revision == 1 and header.content_revision == 0:
                metrics = GpuMetrics_v1_0(buf)
            elif header.format_revision == 1 and header.content_revision == 1:
                metrics = GpuMetrics_v1_1(buf)
            elif header.format_revision == 1 and header.content_revision == 2:
                metrics = GpuMetrics_v1_2(buf)
            elif header.format_revision == 1 and header.content_revision == 3:
                metrics = GpuMetrics_v1_3(buf)
            elif header.format_revision == 2 and header.content_revision == 0:
                metrics = GpuMetrics_v2_0(buf)
            elif header.format_revision == 2 and header.content_revision == 1:
                metrics = GpuMetrics_v2_1(buf)
            elif header.format_revision == 2 and header.content_revision == 2:
                metrics = GpuMetrics_v2_2(buf)
            else:
                raise ValueError("Unsupported metrics v{}.{}".format(
                    header.format_revision, header.content_revision))

            ts = ThrottleStatus(metrics.throttle_status)
            if args.json:
                print(dumps(dict([
                    ("path", filename)] +
                    list(header) +
                    list(metrics) +
                    [('throttle_status_flags', list(ts))
                     ])))
            else:
                print(filename)
                print(header)
                print(metrics)
                print("throttle_status_flags:", ts)
