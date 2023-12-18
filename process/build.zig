const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    inline for ([_][]const u8{ "p1", "p2", "p3", "p4" }) |app| {
        const exe = b.addExecutable(.{
            .name = app,
            .root_source_file = .{ .path = app ++ ".c" },
            .target = target,
            .optimize = optimize,
        });
        exe.linkLibC();
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
