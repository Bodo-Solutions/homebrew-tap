# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1031.4685/bodo-darwin-arm64"
  version "2026.1031.4685"
  sha256 "06b8c0738327656b4c7de08215989f833251fe75b3a75ac354e9f31264afa00a"
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
      url "https://cli.bodo-app.com/v/2026.1031.4685/bodo-linux-arm64"
      sha256 "1e22fb421d299c07f4268c2dc4dda4ff3068ef6b0dfbde1401a0f84f9ace107c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1031.4685/bodo-linux-x64"
      sha256 "687394889a7d10c796d30e4dada5455e81d8e0b8029af67d13a73460c50be0de"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
