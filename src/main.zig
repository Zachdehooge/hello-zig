const std = @import("std");

fn foo() !void {
    var x: u32 = 1;
    var timer: std.time.Timer = try std.time.Timer.start();
    const time_from_start_to_read_ns: u64 = timer.read();

    while (x <= 100) : (x += 1) {
        std.debug.print("x = {}\n", .{x});
    }

    std.debug.print("\nTime taken: {} ms\n", .{time_from_start_to_read_ns});
}

pub fn main() !void {
    try foo();
}
