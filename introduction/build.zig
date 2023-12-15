const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const cpu_exe = b.addExecutable(.{
        .name = "cpu",
        .root_source_file = .{ .path = "cpu.c" },
        .target = target,
        .optimize = optimize,
    });
    cpu_exe.linkLibC();
    cpu_exe.addCSourceFile(.{ .file = std.build.LazyPath.relative("common.c"), .flags = &.{} });
    b.installArtifact(cpu_exe);

    const run_cpu = b.addRunArtifact(cpu_exe);
    run_cpu.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cpu.addArgs(args);
    }
    const cpu_step = b.step("run-cpu", "Run the cpu program");
    cpu_step.dependOn(&run_cpu.step);

    const io_exe = b.addExecutable(.{
        .name = "io",
        .root_source_file = .{ .path = "io.c" },
        .target = target,
        .optimize = optimize,
    });
    io_exe.linkLibC();
    b.installArtifact(io_exe);

    const run_io = b.addRunArtifact(io_exe);
    run_io.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_io.addArgs(args);
    }
    const io_step = b.step("run-io", "Run the io program");
    io_step.dependOn(&run_io.step);

    const mem_exe = b.addExecutable(.{
        .name = "mem",
        .root_source_file = .{ .path = "mem.c" },
        .target = target,
        .optimize = optimize,
    });
    mem_exe.linkLibC();
    mem_exe.addCSourceFile(.{ .file = std.build.LazyPath.relative("common.c"), .flags = &.{} });
    b.installArtifact(mem_exe);

    const run_mem = b.addRunArtifact(mem_exe);
    run_mem.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_mem.addArgs(args);
    }
    const mem_step = b.step("run-mem", "Run the mem program");
    mem_step.dependOn(&run_mem.step);

    const threads_exe = b.addExecutable(.{
        .name = "threads",
        .root_source_file = .{ .path = "threads.c" },
        .target = target,
        .optimize = optimize,
    });
    threads_exe.linkLibC();
    b.installArtifact(threads_exe);

    const run_threads = b.addRunArtifact(threads_exe);
    run_threads.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_threads.addArgs(args);
    }
    const threads_step = b.step("run-threads", "Run the threads program");
    threads_step.dependOn(&run_threads.step);
}
