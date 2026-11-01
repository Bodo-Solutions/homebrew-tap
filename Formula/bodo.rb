# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1101.4688/bodo-darwin-arm64"
  version "2026.1101.4688"
  sha256 "62fb48023525989a4a5b537457b01dfdd66f472915ebee2d417226edb8751c64"
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
      url "https://cli.bodo-app.com/v/2026.1101.4688/bodo-linux-arm64"
      sha256 "aad4de128a6c58095c6374eef4bd5210e8620191f4b78e8c90a2357aac6c901d"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1101.4688/bodo-linux-x64"
      sha256 "99a934dd2128fcb841e516f8952ad3a8b201fc62c2f1775174bb8f21db9975ef"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
