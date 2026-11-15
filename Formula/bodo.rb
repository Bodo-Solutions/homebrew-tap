# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1115.4737/bodo-darwin-arm64"
  version "2026.1115.4737"
  sha256 "e62bcdbd6e3f320413f872e9e9575772ca2d188670d652ab1427be090108940e"
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
      url "https://cli.bodo-app.com/v/2026.1115.4737/bodo-linux-arm64"
      sha256 "b39c6c16c42b9b35cdc37b0532e5a64ebae5ef6eaf38042c8edbd0b266550fc0"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1115.4737/bodo-linux-x64"
      sha256 "f5024e698d9b138738852b0a660dc33b9a099ba608ae260ed34a76f6b9fbfeff"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
