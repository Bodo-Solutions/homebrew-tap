# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1028.4517-rc/bodo-darwin-arm64"
  version "2026.1028.4517-rc"
  sha256 "66f55b35e03a0749fe01f032d2898e93fc0d68791857412364fc17bdbca50926"
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
      url "https://cli.bodo-app.com/v/2026.1028.4517-rc/bodo-linux-arm64"
      sha256 "d083e85aff6dc172df6988feacb887ff3d9378763346e24678ef83424d831bb6"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1028.4517-rc/bodo-linux-x64"
      sha256 "55a9274251269b7ba72f3c4484f0de516c4798f7ecdeed81ddd31e2a28e75e36"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
