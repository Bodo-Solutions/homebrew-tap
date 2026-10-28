# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4525-rc/bodo-darwin-arm64"
  version "2026.1028.4525-rc"
  sha256 "ceade24674cc3678fe18b956fa56cd162bd1ab6990d21525d49e6a281d3f73f0"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1028.4525-rc/bodo-linux-arm64"
      sha256 "0b7125e31705fa511ff3bcc2757a8db9af919544e59fdf389d30b1e2fc595f0b"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4525-rc/bodo-linux-x64"
      sha256 "18079304b60e5b360b0aa37b2656fd5ec2791b06d14d21b99acd503b7843e2ed"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
