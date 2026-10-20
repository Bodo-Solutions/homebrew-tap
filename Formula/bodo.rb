# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1020.4160/bodo-darwin-arm64"
  version "2026.1020.4160"
  sha256 "af8173e5a3772cbc405eb9f87a090251f7664acbebde44fa005c1a1037df5c74"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1020.4160/bodo-linux-arm64"
      sha256 "90b6cbe552395945b054b0cf273e5ca9447e67435e0cf0a69c07b13af2dcb8e9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1020.4160/bodo-linux-x64"
      sha256 "05c5ac5296860a7a89a8f2685037805f9e0f7f11f6ae3dbe951a53f3bd034b3b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
