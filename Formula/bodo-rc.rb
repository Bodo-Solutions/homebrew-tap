# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1022.4239-rc/bodo-darwin-arm64"
  version "2026.1022.4239-rc"
  sha256 "4621c021f957aac34705a7f3a3328dd02869e7e3d373e73821306de42806586e"
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
      url "https://cli.bodo-app.com/v/2026.1022.4239-rc/bodo-linux-arm64"
      sha256 "fa8e3beff5a7e9959c828fb39c9de39b51b6150b8a91cdec3bc8715a0a4ab474"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1022.4239-rc/bodo-linux-x64"
      sha256 "5c6dda8fab1ee4683ac596dab16f19e139abaf19887a1010a7922d40749f8dd0"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
