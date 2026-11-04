# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1104.4695/bodo-darwin-arm64"
  version "2026.1104.4695"
  sha256 "abb94c3e3f38bf1d5e19372d61bc59bb5958794667d5a0ab01b3a55109b382b3"
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
      url "https://cli.bodo-app.com/v/2026.1104.4695/bodo-linux-arm64"
      sha256 "7e27d7ca084b13feac0c2e778696beec38892ab7e4d11b2dcd0b13c468c8dca4"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1104.4695/bodo-linux-x64"
      sha256 "d743f9a58ba734de2572d5112aaeadd2c5334884b5a0b65bff05b20ae2c61e9b"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
