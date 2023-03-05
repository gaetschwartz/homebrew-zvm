class Zvm < Formula
  desc "Simple yet powerful version manager for Zig"
  homepage "https://github.com/gaetschwartz/zvm"
  url "https:/github.com/gaetschwartz/zvm/archive/v0.2.12.tar.gz"
  sha256 "73bb3666fc61d31a3d95dd3b509d0cd70d2905ded45973d8e867ee17af90484f"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-aarch64-0.11.0-dev.1857+010596c93.tar.xz"
        sha256 "6c3cb94abca2d743b7ef1879a6ce526d3e509cbbeacd7dbddd8e89ee063330dc"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-macos-x86_64-0.11.0-dev.1857+010596c93.tar.xz"
        sha256 "274510a486259de58ff0fabd2cf73786975eeec9afa6124b02eeac27609515e6"
      end
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-aarch64-0.11.0-dev.1857+010596c93.tar.xz"
        sha256 "fbf4da87e44a39c6d6f63a21009fe4fcb52cfabbd3a2179b358cdceba1471879"
      end
    else
      resource "zig" do
        url "https://ziglang.org/builds/zig-linux-x86_64-0.11.0-dev.1857+010596c93.tar.xz"
        sha256 "9b925ef92e5405b68b07f7fa56b8e12db55937bfac26947472ef8c2b5447816a"
      end
    end
  end

  resource "known-folders" do
    url "https://github.com/ziglibs/known-folders/archive/53fe3b676f32e59d46f4fd201d7ab200e5f6cb98.tar.gz"
    sha256 "3c9d1e293df9e3e48b96114859267c2bf5d8cc924e7e5f7a9628d0c77bb43709"
  end

  def install
    resource("zig").unpack "ziglang-org/zig"
    resource("known-folders").unpack "known-folders"
    ohai "Building zvm... (this may take a while)"
    system "ziglang-org/zig/zig", "build", "-Doptimize=ReleaseSafe"
    bin.install "zig-out/bin/zvm"
    generate_completions_from_executable(bin/"zvm", "completions", "--shell", "zsh", shells: [:zsh])
  end

  test do
    system "#{bin}/zvm", "--version", "--verbose"
  end
end
