const std = @import("std");

// Sample function to demonstrate a simple loop and timer usage
fn foo() !void {
    var x: u8 = 1;
    var timer: std.time.Timer = try std.time.Timer.start();
    const time_from_start_to_read_ns: u64 = timer.read();

    while (x <= 100) : (x += 1) {
        std.debug.print("x = {}\n", .{x});
    }

    std.debug.print("\nTime taken: {} ms\n", .{time_from_start_to_read_ns});
}

// Error handling example with a custom error type
const less_than_10 = error{
    less_than_10,
};
fn bar(x: u8) !u8 {
    if (x <= 9) {
        return error.less_than_10;
    } else {
        return x;
    }
}

pub fn main() !void {
    var buffer: [100]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    std.debug.print("Enter a number: ", .{});

    const input_slice = try stdin.readUntilDelimiter(&buffer, '\n');

    const input_number = try std.fmt.parseInt(u8, input_slice, 10);
    try stdout.print("The user entered: {}\n", .{input_number});

    const bars = bar(input_number) catch |err| {
        std.debug.print("{}\n", .{err});
        return;
    };

    std.debug.print("x = {}\n", .{bars});
}
