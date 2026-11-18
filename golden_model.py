import sys
import random

def alu_golden_model(a, b, op):
    # Example: Calculate 8-bit result for 5-bit inputs 
    if op == 0: return (a + b) & 0xFF
    elif op == 1: return (a - b) & 0xFF
    return 0

def main():
    # Inherit the random seed from QuestaSim's testbench
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 12345
    random.seed(seed)

    with open("inputs.hex", "w") as f_in, open("golden.hex", "w") as f_out:
        # Generate 50 random test vectors
        for _ in range(50):
            a = random.randint(0, 31)    # 5-bit input
            b = random.randint(0, 31)    # 5-bit input
            op = random.randint(0, 3)

            expected = alu_golden_model(a, b, op)

            # Write hex values
            f_in.write(f"{a:02x} {b:02x} {op:01x}\n")
            f_out.write(f"{expected:02x}\n")

if __name__ == "__main__":
    main()