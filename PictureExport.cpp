/*****************************************************************************
* gta5sync GRAND THEFT AUTO V SYNC
* Copyright (C) 2016 Syping
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*****************************************************************************/

#include "config.h"
#include "PictureExport.h"
#include "PictureDialog.h"
#include "StandardPaths.h"
#include "SidebarGenerator.h"
#include <QMessageBox>
#include <QFileDialog>
#include <QSettings>
#include <QDebug>

PictureExport::PictureExport()
{

}

void PictureExport::exportPicture(QWidget *parent, SnapmaticPicture *picture)
{
    QSettings settings(GTA5SYNC_APPVENDOR, GTA5SYNC_APPSTR);
    settings.beginGroup("FileDialogs");
    settings.beginGroup("ExportPicture");

fileDialogPreSave:
    QFileDialog fileDialog(parent);
    fileDialog.setFileMode(QFileDialog::AnyFile);
    fileDialog.setViewMode(QFileDialog::Detail);
    fileDialog.setAcceptMode(QFileDialog::AcceptSave);
    fileDialog.setOption(QFileDialog::DontUseNativeDialog, false);
    fileDialog.setOption(QFileDialog::DontConfirmOverwrite, true);
    fileDialog.setDefaultSuffix("suffix");
    fileDialog.setWindowFlags(fileDialog.windowFlags()^Qt::WindowContextHelpButtonHint);
    fileDialog.setWindowTitle(PictureDialog::tr("Export as JPG picture..."));
    fileDialog.setLabelText(QFileDialog::Accept, PictureDialog::tr("&Export"));

    QStringList filters;
    filters << PictureDialog::tr("JPEG picture (*.jpg)");
    filters << PictureDialog::tr("Portable Network Graphics (*.png)");
    fileDialog.setNameFilters(filters);

    QList<QUrl> sidebarUrls = SidebarGenerator::generateSidebarUrls(fileDialog.sidebarUrls());

    fileDialog.setSidebarUrls(sidebarUrls);
    fileDialog.setDirectory(settings.value("Directory", StandardPaths::picturesLocation()).toString());
    fileDialog.restoreGeometry(settings.value(parent->objectName() + "+Geomtery", "").toByteArray());

    if (picture != 0)
    {
        QString newPictureFileName = getPictureFileName(picture);
        fileDialog.selectFile(newPictureFileName);
    }

    if (fileDialog.exec())
    {
        QStringList selectedFiles = fileDialog.selectedFiles();
        if (selectedFiles.length() == 1)
        {
            QString saveFileFormat;
            QString selectedFile = selectedFiles.at(0);

            if (selectedFile.right(4) == ".jpg")
            {
                saveFileFormat = "JPEG";
            }
            else if (selectedFile.right(4) == ".jpeg")
            {
                saveFileFormat = "JPEG";
            }
            else if (selectedFile.right(4) == ".png")
            {
                saveFileFormat = "PNG";
            }
            else if (selectedFile.right(7) == ".suffix")
            {
                if (fileDialog.selectedNameFilter() == "JPEG picture (*.jpg)")
                {
                    selectedFile.replace(".suffix", ".jpg");
                }
                else if (fileDialog.selectedNameFilter() == "Portable Network Graphics (*.png)")
                {
                    selectedFile.replace(".suffix", ".png");
                }
                else
                {
                    selectedFile.replace(".suffix", ".jpg");
                }
            }

            if (QFile::exists(selectedFile))
            {
                if (QMessageBox::Yes == QMessageBox::warning(parent, PictureDialog::tr("Export as JPG picture"), PictureDialog::tr("Overwrite %1 with current Snapmatic picture?").arg("\""+selectedFile+"\""), QMessageBox::Yes | QMessageBox::No, QMessageBox::Yes))
                {
                    if (!QFile::remove(selectedFile))
                    {
                        QMessageBox::warning(parent, PictureDialog::tr("Export as JPG picture"), PictureDialog::tr("Failed to overwrite %1 with current Snapmatic picture").arg("\""+selectedFile+"\""));
                        goto fileDialogPreSave;
                    }
                }
                else
                {
                    goto fileDialogPreSave;
                }
            }

            bool isSaved = picture->getPicture().save(selectedFile, saveFileFormat.toStdString().c_str(), 100);

            if (!isSaved)
            {
                QMessageBox::warning(parent, PictureDialog::tr("Export as JPG picture"), PictureDialog::tr("Failed to export current Snapmatic picture"));
                goto fileDialogPreSave;
            }
        }
        else
        {
            QMessageBox::warning(parent, PictureDialog::tr("Export as JPG picture"), PictureDialog::tr("No valid file is selected"));
            goto fileDialogPreSave;
        }
    }

    settings.setValue(parent->objectName() + "+Geometry", fileDialog.saveGeometry());
    settings.setValue("Directory", fileDialog.directory().absolutePath());
    settings.endGroup();
    settings.endGroup();
}

QString PictureExport::getPictureFileName(SnapmaticPicture *picture)
{
    return picture->getExportPictureFileName();
}
