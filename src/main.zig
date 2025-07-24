const std = @import("std");

// Sample function to demonstrate a simple loop and timer usage
fn foo(iterations: u8) !void {
    var x: u8 = 1;
    var timer: std.time.Timer = try std.time.Timer.start();
    const time_from_start_to_read_ns: u64 = timer.read();

    while (x <= iterations) : (x += 1) {
        std.debug.print("x = {}\n", .{x});
    }

    std.debug.print("\nTime taken: {} ms\n", .{time_from_start_to_read_ns});
}

// Error handling example with a custom error type
const less_than_10 = error{
    equal_to_0,
};
fn bar(x: u8) !u8 {
    if (x <= 0) {
        return error.equal_to_0;
    } else {
        return x;
    }
}

// Main function to read user input and demonstrate error handling
pub fn main() !void {
    var buffer: [100]u8 = undefined;
    const stdin = std.io.getStdIn().reader();

    std.debug.print("\n", .{});

    std.debug.print("Enter a number: ", .{});

    const input_slice = try stdin.readUntilDelimiter(&buffer, '\n');

    const input_number = try std.fmt.parseInt(u8, input_slice, 10);

    const bars = bar(input_number) catch |err| {
        std.debug.print("{}\n", .{err});
        return;
    };

    std.debug.print("\n", .{});

    foo(bars) catch |err| {
        std.debug.print("Error in foo: {}\n", .{err});
        return;
    };
}
