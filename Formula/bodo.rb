# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1104.4698/bodo-darwin-arm64"
  version "2026.1104.4698"
  sha256 "6fb7a3ce0721197c4562e18e7ce978b0e8d6bc19fe17643d8686b8d25009970f"
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
      url "https://cli.bodo-app.com/v/2026.1104.4698/bodo-linux-arm64"
      sha256 "47c1fbe737f27ce9caeefd7f52a02479990d7f5d051f641894ee9cb3dede33a2"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1104.4698/bodo-linux-x64"
      sha256 "1f81ade9f7955805aaf7ee0047e2fa82efcfe8ea7729570344535a260d065ac2"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
