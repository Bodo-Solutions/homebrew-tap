# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1025.4368-rc/bodo-darwin-arm64"
  version "2026.1025.4368-rc"
  sha256 "fba3b76c553c4f4f384dab797738fd49ac4360de299a0381c244741f82cbba0c"
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
      url "https://cli.bodo-app.com/v/2026.1025.4368-rc/bodo-linux-arm64"
      sha256 "0074b04d9caae5cc279428ffc37104e80e50e4a994edc6fb5f1fbd8aa1848bf6"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1025.4368-rc/bodo-linux-x64"
      sha256 "3ed974f8701d0080f38925d38fa240392fae4c79579a57a59b1e1db3800e6f39"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
