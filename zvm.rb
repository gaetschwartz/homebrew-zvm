class Zvm < Formula
  desc "Simple yet powerful version manager for Zig"
  homepage "https://github.com/gaetschwartz/zvm"
  url "https:/github.com/gaetschwartz/zvm/archive/v0.2.14.tar.gz"
  sha256 "abc9f6dfb460bed02cca792c89f6593fb13ee5796983a220e83dffe7b8efe817"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-aarch64-0.11.0-dev.1897+6218e4004.tar.xz"
        sha256 "aa270a026c7ddace20e56149882e825f539b4f563f6716f79ac8cb7cd3483a6f"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-x86_64-0.11.0-dev.1897+6218e4004.tar.xz"
        sha256 "4c0905d549cefbbfa4fe591e473af59f3cd263b4c74d1a79db88e99b4b0dbb5b"
      end
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-aarch64-0.11.0-dev.1897+6218e4004.tar.xz"
        sha256 "8a71409917a95100315fcae41e79ecf97d109f9145c5dc8d6d4314f48b0a5a9b"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-x86_64-0.11.0-dev.1897+6218e4004.tar.xz"
        sha256 "4d68b050ad3788559f2a7ab2f2af54b4630a1007c4d77f71c76efa8dd62a840c"
      end
    end
  end

  def install
    resource("zig").unpack "ziglang-org/zig"
    ohai "Building zvm... (this may take a while)"
    system "ziglang-org/zig/zig", "build", "-Doptimize=ReleaseSafe"
    bin.install "zig-out/bin/zvm"
    generate_completions_from_executable(bin/"zvm", "completions", "--shell", "zsh", shells: [:zsh])
  end

  test do
    system "#{bin}/zvm", "--version"
  end
end
