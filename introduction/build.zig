const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    inline for ([_][]const u8{ "cpu", "io", "mem", "threads" }) |app| {
        const exe = b.addExecutable(.{
            .name = app,
            .root_source_file = .{ .path = app ++ ".c" },
            .target = target,
            .optimize = optimize,
        });
        exe.linkLibC();
        exe.addCSourceFile(.{ .file = std.build.LazyPath.relative("common.c"), .flags = &.{} });
        b.installArtifact(exe);

        const run = b.addRunArtifact(exe);
        run.step.dependOn(b.getInstallStep());
        if (b.args) |args| {
            run.addArgs(args);
        }
        const step = b.step("run-" ++ app, "Run the " ++ app ++ " program");
        step.dependOn(&run.step);
    }
}
