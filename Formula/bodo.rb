# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1121.4762/bodo-darwin-arm64"
  version "2026.1121.4762"
  sha256 "e1a7777df166ee8973739c81c28ab9d48c38ccba5ee1fd2c7cf00285cd7dc015"
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
      url "https://cli.bodo-app.com/v/2026.1121.4762/bodo-linux-arm64"
      sha256 "0fb2d7823f75976b381b6783da63a2ae34aef838d090e3a3eb7012ce996fda89"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1121.4762/bodo-linux-x64"
      sha256 "6ca2d3a110c7221202eddf2ccad7229f268db9afbe7698d84debff941af28762"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
